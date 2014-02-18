module DocSmoosher
  class Request < ApiObject
    attr_accessor :call_type, :path

    def initialize args
      # set some defaults

      # path is plural of name by default
      args[:path] = args[:name].pluralize unless args[:path] 
      
      # call type is get by default
      args[:call_type] = :get unless args[:call_type]

      super
    end
  end
end