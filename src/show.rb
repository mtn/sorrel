
def space_delimit(arr,readable=true)
    arr.map { |x| show(x,readable) }.join(' ')
end

def show_hash(hash,readable=true)
    hash.map { |k,v| show(k,readable) + ' ' + show(v,readable) }.join(' ')
end

def show(inp,readable=true)
    case inp
    when NilClass
        then 'nil'
    when Array
        then '(' + space_delimit(inp,readable) + ')'
    when String
        if inp[0] == "\u029e"
            ':' + inp[1..-1]
        elsif readable
            return inp.inspect
        else
            return inp
        end
    when Atom
        then "(atom " + show(inp.val,true) + ")"
    when Function
        then '#<function>'
    when Hash
        then '{' + show_hash(inp,readable) + '}'
    else
        inp.to_s
    end
end

def PRINT(showable)
    puts show(showable,true)
end

