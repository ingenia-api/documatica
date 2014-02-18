module DocSmoosher
  class Resource < ApiObject
    attr_accessor :requests

    def initialize(params = {}, &block)
      super(params)
    end

    def requests
      @requests ||= []
    end

    def request( params = {}, &block )
      r = Request.new( params, &block )
      requests << r unless requests.include?(r)
      r
    end

    def as_json(options={})
      {
        :name => name,
        :description => description,
        :requests => self.requests.map(&:as_json)
      }
    end

  end
end
