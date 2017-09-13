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
    token = reader.next
    if token != '('
        raise "expected '('"
    end
    while (token = reader.peek) != ')'
        if not token
            raise "expected ')', got EOF"
        end
        ast.push(read_form(reader))
    end
    reader.next # consume trailing ')'

    ast
end

def read_atom(reader)
    case (token = reader.next)
    when /^-?[0-9]+$/ then
        token.to_i
    when 'nil' then
        nil
    when 'true' then
        true
    when 'false' then
        false
    else
        token.to_sym
    end
end

def read_form(reader)
    case reader.peek
    when '(' then
        read_list(reader)
    else
        read_atom(reader)
    end
end

def READ(inp)
    read_str(inp)
end


