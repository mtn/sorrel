require 'readline'
require_relative 'reader'
require_relative 'show'


def READ(inp)
    read_str(inp)
end

def EVAL(arg)
    arg
end

def PRINT(showable)
    puts show(showable)
end

def rep(arg)
    PRINT(EVAL(READ(arg)))
end

while buf = Readline.readline('>> ', true)
    rep(buf)
end

