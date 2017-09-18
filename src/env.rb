require_relative 'core'

class Env
    attr_accessor :data

    def initialize(outer=nil,terms=[],exprs=[])
        @data = {}
        @outer = outer
        terms.each_with_index { |b,i|
            @data[b] = exprs[i]
        }
    end

    def set(key,val)
        @data[key] = val
    end

    def find(key)
        if @data.has_key?(key)
            self
        elsif @outer
            @outer.find(key)
        else
            nil
        end
    end

    def get(key)
        if (env = find(key))
            env.data[key]
        else
            throw "Symbol not found"
        end
    end

end

#TODO Add command line option for running without core
def create_repl_env(withCore=true)
    repl_env = Env.new

    $ns.each { |key,val|
        repl_env.set(key,val)
    }

    repl_env.set(:eval, lambda { |x| EVAL(x,repl_env) })

    if withCore
        File.readlines("#{File.expand_path(File.dirname(__FILE__))}/lib/core.mal").each { |line|
            if not line.chomp == ""
                EVAL(READ(line.chomp),repl_env)
            end
        }
    end

    repl_env
end

