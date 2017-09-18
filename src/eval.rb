require_relative 'types'

def eval_ast(ast,env)
    case ast
    when Symbol then
        unless env.get(ast)
            throw "Symbol not found"
        end
        env.get(ast)
    when Array then
        ast.map { |x| EVAL(x,env) }
    else
        ast
    end
end

def EVAL(ast,env)
    while true
        if not ast.is_a? Array
            return eval_ast(ast,env)
        end
        if ast.empty?
            return ast
        end

        case ast[0]
        when :def! then
            return env.set(ast[1],EVAL(ast[2],env))
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
        else
            el = eval_ast(ast,env)
            f = el[0]
            if f.class == Function
                ast = f.ast
                env = f.gen_env(el.drop(1))
            else
                return f.call(*el.drop(1))
            end
        end

    end
end
