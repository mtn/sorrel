require 'readline'
require_relative 'read'
require_relative 'show'
require_relative 'eval'
require_relative 'env'


def rep(arg,env)
    PRINT(EVAL(READ(arg),env))
end

repl_env = create_repl_env
while buf = Readline.readline('>> ', true)
    begin
    rep(buf,repl_env)
    rescue => e
        p 'Error: ' + e.message
    end
end

