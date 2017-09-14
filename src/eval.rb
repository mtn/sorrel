
def eval_ast(ast,env)
    case ast
    when Symbol then
        unless env.get(ast)
            throw "Symbol not found"
        end
        env.get(ast)
    when Array then
        ast.map { |x|
            EVAL(x,env)
        }
    else
        ast
    end
end

def EVAL(ast,env)
    case ast
    when Array then
        if ast.empty?
            return ast
        end

        case ast[0]
        when :def! then
            env.set(ast[1],EVAL(ast[2],env))
        when :'let*' then
            inner = Env.new(env)
            ast[1].each_slice(2) do |k,v|
                inner.set(k,EVAL(v,inner))
            end
            eval_ast(ast[2],inner)
        when :do then
            eval_ast(ast.drop(1),env).last
        when :if then
            if EVAL(ast[1],env)
                EVAL(ast[2],env)
            elsif ast[3]
                EVAL(ast[3],env)
            else
                return nil
            end
        when :'fn*' then
            lambda { |*x|
                EVAL(ast[2],Env.new(env,ast[1],x))
            }
        else
            ast = eval_ast(ast,env)
            ast[0].call(*ast.drop(1))
        end
    else
        eval_ast(ast,env)
    end
end
