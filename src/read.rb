
class Reader

    def initialize(tokens)
        raise EmptyInputError if tokens == []
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

def read_list(reader,open='(',close=')')
    ast = []
    token = reader.next
    if token != open
        raise "expected '#{open}'"
    end
    while (token = reader.peek) != close
        if not token
            raise "expected '#{close}', got EOF"
        end
        ast.push(read_form(reader))
    end
    reader.next # consume trailing ')'

    ast
end

def parse_str(token)
    token[1..-2].gsub(/\\"/, '"').gsub(/\\n/, "\n").gsub(/\\\\/, "\\")
end

def read_atom(reader)
    case (token = reader.next)
    when /^-?[0-9]+$/ then
        token.to_i
    when /^:/ then
        "\u029e" + token[1..-1]
    when 'nil' then
        nil
    when 'true' then
        true
    when 'false' then
        false
    when /^".*"$/ then
        parse_str(token)
    else
        token.to_sym
    end
end

def read_form(reader)
    case reader.peek
    when '(' then
        read_list(reader)
    when '[' then
        read_list(reader,'[',']')
    when "{" then
        Hash[read_list(reader,"{", "}").each_slice(2).to_a]
    when '@' then
        reader.next
        [:deref,read_form(reader)]
    when "'" then
        reader.next
        [:quote,read_form(reader)]
    when '`' then
        reader.next
        [:quasiquote,read_form(reader)]
    when '~@' then
        reader.next
        [:'splice-unquote',read_form(reader)]
    when '~' then
        reader.next
        [:unquote,read_form(reader)]
    else
        read_atom(reader)
    end
end

def READ(inp)
    read_str(inp)
end


