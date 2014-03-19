module DocSmoosher
  class Resource < ApiObject
    attr_accessor :requests, :parameters

    def initialize(params = {}, &block)
      super(params)
    end

    def requests
      @requests ||= []
    end

    def parameters
      @parameters ||= []
    end

    def request( params = {}, &block )
      r = Request.new( params, &block )
      requests << r unless requests.include?(r)
      r
    end

		def response( params = {}, &block)
			responses << Response.new( params, &block )
		end


    def as_json(options={})
      json = super
      if self.requests.length > 0
        json.merge(
          {
            :requests => self.requests.map(&:as_json)
          }
        )
      end
      if self.parameters.length > 0
        json.merge(
          {
            :parameters => self.parameters.map(&:as_json)
          }
        )
      end
      json
    end

  end
end
