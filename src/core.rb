
$ns = {
    '=':  lambda { |x,y| x == y },
    '<':  lambda { |x,y| x < y },
    '>':  lambda { |x,y| x > y },
    '<=': lambda { |x,y| x <= y },
    '>=': lambda { |x,y| x >= y },

    '+': lambda { |a,b| a+b      },
    '-': lambda { |a,b| a-b      },
    '*': lambda { |a,b| a*b      },
    '/': lambda { |a,b| int(a/b) },

    'list':   lambda { |*x| x },
    'list?':  lambda { |*x| x[0].is_a? Array },
    'empty?': lambda { |x| x.empty? },
    'count':  lambda { |x| x.count },

    'prn':         lambda { |*x| puts x.map {|e| show(e)}.join(' ') },
    'slurp':       lambda { |x| File.read(x.to_s) },
    'read-string': lambda { |x| read_str x.to_s },
    'str':         lambda { |*x| x.map {|y| show(y, false)}.join("")},
}

