require 'readline'
require_relative 'read'
require_relative 'show'
require_relative 'eval'
require_relative 'env'
require_relative 'core'


def rep(arg,env)
    PRINT(EVAL(READ(arg),env))
end

repl_env = create_repl_env
if ARGV.size > 0
    rep("(load-file \"#{ARGV[0]}\")",repl_env)
    return
end

while buf = Readline.readline('>> ', true)
    begin
        rep(buf,repl_env)
    rescue => e
        puts "Error: '#{e.message}'"
    end
end

