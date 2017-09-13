
def space_delimit(arr)
    spaced = ''
    num_terms = arr.length
    arr.each_with_index { |x,ind|
        if ind != num_terms - 1
            spaced += x.to_s + ' '
        else
            spaced += x.to_s
        end
    }
    spaced
end

def show(inp)
    case inp
    when Integer
        then inp.to_s
    when TrueClass
        then inp.to_s
    when FalseClass
        then inp.to_s
    when NilClass
        then 'nil'
    when Array
        then '(' + space_delimit(inp) + ')'
    end
end

