
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

    'sequential?': lambda { |x| x.is_a? Array },
    'keyword?':    lambda { |x| x.is_a? String && x[0] == '\u029e' },
    'keyword':     lambda { |x| '\u029e'+x },
    'false?':      lambda { |x| x == false },
    'symbol?':     lambda { |x| x.is_a? Symbol },
    'symbol':      lambda { |x| x.to_sym },
    'true?':       lambda { |x| x == true },
    'nil?':        lambda { |x| x == nil },

    'list':   lambda { |*x| x },
    'list?':  lambda { |*x| x[0].is_a? Array },
    'empty?': lambda { |x| x.empty? },
    'count':  lambda { |x| return 0 if x == nil; x.count },
    'cons':   lambda { |x,xs| xs.clone.insert(0,x) },
    'concat': lambda { |*xs| xs && xs.reduce(:+) || [] },
    'nth':    lambda { |xs,n| raise 'Index out of bounds' if n >= xs.size; xs[n] },
    'first':  lambda { |xs| nil if xs == nil || xs.size < 1; xs[0] },
    'rest':   lambda { |xs| xs.drop(1) },

    'prn':         lambda { |*x| puts x.map {|e| show(e)}.join(' ') },
    'str':         lambda { |*x| x.map {|y| show(y,false)}.join("")},
    'slurp':       lambda { |x| File.read(x.to_s) },
    'read-string': lambda { |x| read_str x.to_s },

    'atom':   lambda { |x| Atom.new(x) },
    'atom?':  lambda { |x| x.is_a? Atom },
    'swap!':  lambda { |*x| x[0].val = x[1].fn.call(*[x[0].val].concat(x.drop(2))) },
    'deref':  lambda { |x| x.val },
    'reset!': lambda { |x,v| x.val=v },

    'throw': lambda { |x| raise x },
    'apply': lambda { |*x| x[0].call(*x[1..-2].concat(x[-1])) },
    'map':   lambda { |x,y| y.map { |a| x.call(a) } },
}

