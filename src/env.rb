
$repl_symbols = {'+': lambda { |a,b| a+b      },
                 '-': lambda { |a,b| a-b      },
                 '*': lambda { |a,b| a*b      },
                 '/': lambda { |a,b| int(a/b) }
}

class Env

    attr_accessor :data

    def initialize(outer=nil)
        @data = {}
        @outer = outer
    end

    def set(key,val)
        @data[key] = val
    end

    def find(key)
        if @data.has_key?(key)
            self
        elsif outer
            @outer.find(key)
        else
            return nil
        end
    end

    def get(key)
        if (env = find(key))
            @data[key]
        else
            throw "Symbol not found"
        end
    end

end

def create_repl_env
    repl_env = Env.new(nil)
    $repl_symbols.each { |key,val|
        repl_env.set(key,val)
    }
    repl_env
end
