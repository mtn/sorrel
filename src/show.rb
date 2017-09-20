
def space_delimit(arr,readable=true)
    puts 'this was invoked'
    arr.map{ |x| show(x,readable) }.join(' ')
end

def show(inp,readable=true)
    case inp
    when NilClass
        then 'nil'
    when Array
        then '(' + space_delimit(inp,readable) + ')'
    when String
        if readable
            return inp.inspect
        else
            return inp
        end
    when Atom
        then "(atom " + show(inp.val,true) + ")"
    when Function
        then '#<function>'
    else
        inp.to_s
    end
end

def PRINT(showable)
    puts show(showable,true)
end

