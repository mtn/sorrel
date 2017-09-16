
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
            eval_ast(ast,env)
        end
        if ast.empty?
            ast
        end

        case ast[0]
        when :def! then
            env.set(ast[1],EVAL(ast[2],env))
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
                nil
            end
        when :'fn*' then
            Function.new(ast[2],env,ast[1],lambda {|*x|
                EVAL(ast[2],Env.new(env,ast[1],x))
            })
        else
            p 'calling'
            p ast
            el = eval_ast(ast,env)
            p 'el'
            p el
            f = el[0]
            if f.class == Function
                ast = f.ast
                env = f.gen_env(el.drop(1)) # Continue loop (TCO)
            else
                return f[*el.drop(1)]
            end
        end

    end
end
