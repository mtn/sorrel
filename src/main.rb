require 'readline'
require_relative 'read'
require_relative 'show'
require_relative 'eval'


def rep(arg,env)
    PRINT(EVAL(READ(arg),env))
end

while buf = Readline.readline('>> ', true)
    begin
    rep(buf,$repl_env)
    rescue => e
        p 'Error: ' + e.message
    end
end

