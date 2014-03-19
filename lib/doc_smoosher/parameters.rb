module DocSmoosher

  module Parameters
    attr_accessor :parameters, :resource

    def parameters
      @parameters ||= []
    end

    def parameter(params = {}, &block)
      if [Parameter, ApiObject].include?(params.class)
        p = params
      else
        p = Parameter.new(params, &block)
      end
      parameters << p unless parameters.include?(p)
      p
    end
  end
end
