
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
        ast = eval_ast(ast,env)
        ast[0].call(*ast.drop(1))
    else
        eval_ast(ast,env)
    end
end
