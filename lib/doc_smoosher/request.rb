module DocSmoosher
  class Request < ApiObject
    attr_accessor :call_type, :path, :parameters, :fields

    def initialize(params = {}, &block)
      # Defaults
      self.call_type = :get
      
      super(params)
    end

    def parameters
      @parameters ||= []
    end

    def parameter(params = {}, &block)
      p = Parameter.new(params, &block)
      parameters << p unless parameters.include?(p)
      p
    end

    def fields
      @fields ||= []
    end

    def as_json(options={})
      super.merge(
        {
          :fields => fields.map(&:as_json),
          :parameters => parameters.map(&:as_json)
        }
      )
    end
  end
end