require 'readline'

def evaluate(arg)
    arg
end

while buf = Readline.readline('>> ', true)
  p evaluate(buf)
end

