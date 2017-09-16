
class Function
    attr_accessor :ast
    attr_accessor :env
    attr_accessor :params

    def initialize(ast,params,env,fn)
        @ast = ast
        @params = params
        @env = env
        @fn = fn
    end
end
