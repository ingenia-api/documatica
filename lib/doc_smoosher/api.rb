module DocSmoosher
  class Api < ApiObject
    attr_accessor :endpoint, :version, :format, :resources, :resquests, :objects

    def resources
      @resources ||= []
    end

    def objects
      @objects ||= []
    end

    def resquests
      @resquests ||= []
    end

    def request( params = {}, &block )

    end

    def resource( params = {}, &block )
      r = Resource.new( params, &block )
      resources << r unless resources.include?(r)
      r
    end


    def object( params = {}, &block )
      if params.class == ApiObject
        o = params
      else
        o = ApiObject.new( params, &block )
      end
      
      objects << o unless objects.include?(o)
      o
    end

    def initialize(params = {}, &block)
      super(params)
    end


    def as_json(options={})
      {
        :name => name,
        :description => description,
        :version => version,
        :format => format,
        :resources => self.resources.map(&:as_json)
      }
    end
  end
end