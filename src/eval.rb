require_relative 'types'

def is_pair(x)
    (x.is_a? Array) && x.size > 0
end

def is_macro_call(ast,env)
    return (ast.is_a? Array) &&
           (ast[0].is_a? Symbol) &&
           (env.find(ast[0])) &&
           (env.get(ast[0]).is_a? Function) &&
           (env.get(ast[0]).is_macro)
end

def macroexpand(ast,env)
    while is_macro_call(ast,env)
        f = env.get(ast[0])
        ast = f.fn[*ast.drop(1)]
    end
    ast
end

def quasiquote(ast)
    if not is_pair(ast)
        [:quote,ast]
    elsif ast[0] == :unquote
        ast[1]
    elsif is_pair(ast) and ast[0][0] == :'splice-unquote'
        [:concat,ast[0][1],quasiquote(ast.drop(1))]
    else
        [:cons,quasiquote(ast[0]),quasiquote(ast.drop(1))]
    end
end

def eval_ast(ast,env)
    case ast
    when Symbol then
        env.get(ast)
    when Array then
        ast.map { |x| EVAL(x,env) }
    when Hash then
        hm = {}
        ast.each { |k,v| hm[EVAL(k,env)] = EVAL(v,env) }
        hm
    else
        ast
    end
end

def EVAL(ast,env)
    while true
        if not ast.is_a? Array
            return eval_ast(ast,env)
        end
        ast = macroexpand(ast,env)
        if not ast.is_a? Array
            return eval_ast(ast,env)
        end
        if ast.empty?
            return ast
        end

        case ast[0]
        when :def! then
            return env.set(ast[1],EVAL(ast[2],env))
        when :defmacro! then
            f = EVAL(ast[2],env)
            f.is_macro = true
            return env.set(ast[1],f)
        when :macroexpand then
            return macroexpand(ast[1],env)
        when :'let*' then
            inner = Env.new(env)
            ast[1].each_slice(2) do |k,v|
                inner.set(k,EVAL(v,inner))
            end
            env = inner
            ast = ast[2]
        when :do then
            eval_ast(ast[1..-2],env)
            ast = ast.last
        when :if then
            if EVAL(ast[1],env)
                ast = ast[2]
            elsif ast[3]
                ast = ast[3]
            else
                return nil
            end
        when :'fn*' then
            return Function.new(ast[2],ast[1],env,lambda { |*x|
                EVAL(ast[2],Env.new(env,ast[1],x))
            })
        when :quote then
            return ast[1]
        when :quasiquote then
            ast = quasiquote(ast[1])
        when :'try*' then
            begin
                return EVAL(ast[1],env)
            rescue => e
                return EVAL(ast[2][2],Env.new(env,[ast[2][1]],[e]))
            end
        else
            el = eval_ast(ast,env)
            f = el[0]
            if f.class == Function
                ast = f.ast
                env = f.gen_env(el.drop(1))
            else
                return f[*el.drop(1)]
            end
        end

    end
end
