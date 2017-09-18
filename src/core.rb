
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
    'cons':   lambda { |x,xs| xs.clone.insert(0,x) },
    'concat': lambda { |*xs| xs && xs.reduce(:+) || [] },

    'prn':         lambda { |*x| puts x.map {|e| show(e)}.join(' ') },
    'str':         lambda { |*x| x.map {|y| show(y,false)}.join("")},
    'slurp':       lambda { |x| File.read(x.to_s) },
    'read-string': lambda { |x| read_str x.to_s },

    'atom':   lambda { |x| Atom.new(x) },
    'atom?':  lambda { |x| x.is_a? Atom },
    'swap!':  lambda { |*x| x[0].val = x[1].fn.call(*[x[0].val].concat(x.drop(2))) },
    'deref':  lambda { |x| x.val },
    'reset!': lambda { |x,v| x.val=v },
}

