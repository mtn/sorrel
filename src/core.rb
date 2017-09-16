
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

    'prn': lambda { |*x| puts x.map {|e| show(e)}.join(' ') },

    'list':   lambda { |*x| x },
    'list?':  lambda { |*x| x[0].is_a? Array },
    'empty?': lambda { |x| x.empty? },
    'count':  lambda { |x| x.count },

}

