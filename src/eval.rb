
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
        else
            ast = eval_ast(ast,env)
            ast[0].call(*ast.drop(1))
        end
    else
        eval_ast(ast,env)
    end
end
