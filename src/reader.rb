class Reader

    def initialize(tokens)
        @tokens = tokens
        @ind = 0
    end

    def next
        @ind += 1
        @tokens[@ind-1]
    end

    def peek
        @tokens[@ind]
    end

end

def tokenize(str)
    str.scan(/[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"|;.*|[^\s\[\]{}('"`,;)]*)/)
        .map{|m| m[0]}.select{ |t|
            t != "" && t[0..0] != ";"
        }
end

def read_str(inp)
    read_form Reader.new tokenize(inp)
end

def read_list(reader)
    ast = []
    p reader
    token = reader.next
    if token != '('
        raise "expected ')'"
    end
    while reader.peek != ')'
        if not token
            raise "expected ')', got EOF"
        end
        a = read_form(reader)
        ast.push(a)
    end
    reader.next # consume trailing ')'

    ast
end

def read_atom(reader)
    reader.next
end

def read_form(reader)
    return case reader.peek
    when '('
        then read_list(reader)
    else
        read_atom(reader)
    end
end


p tokenize('(-a ( 1 ) 2)')
p read_str('(-a ( 1 ) 2)')
