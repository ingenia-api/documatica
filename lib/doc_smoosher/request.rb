module DocSmoosher
  class Request < ApiObject
    attr_accessor :call_type, :path, :fields, :response

    def initialize(params = {}, &block)
      # Defaults
      self.call_type = :get
      
      super(params)
    end


    def fields
      @fields ||= []
    end

    def field(params = {}, &block)
      if params.class == Field
        f = params
      else
        f = Field.new(params, &block)
      end
      fields << f unless fields.include?(f)
      p
    end

    def to_params
      params = {}
      parameters.map{ |p| params[p.name] = p.test_value }

      params
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