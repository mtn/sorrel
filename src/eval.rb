
$repl_env = {'+': lambda { |a,b| a+b      },
             '-': lambda { |a,b| a-b      },
             '*': lambda { |a,b| a*b      },
             '/': lambda { |a,b| int(a/b) }
}


def eval_ast(ast,env)
    case ast[0]
    when Symbol then
        env[ast[0]].call(ast[1],ast[2])
    when Array then
        ast.map { |x|
            eval_ast(x,env)
        }
    else
        ast
    end
end

def EVAL(ast,env)
    eval_ast(ast,env)
end
