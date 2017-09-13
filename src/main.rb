require 'readline'
require_relative 'reader'
require_relative 'show'

def evaluate(arg)
    # tokenize(arg)
    read_str(arg)
end

while buf = Readline.readline('>> ', true)
  p evaluate(buf)
end

