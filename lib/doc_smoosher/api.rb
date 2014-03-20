module DocSmoosher
  class Api < ApiObject

    attr_accessor :endpoint, :version, :format

    def resources
      @resources ||= []
    end

    def objects
      @objects ||= []
    end

    def intros
      @intros ||= []
    end
    
    def requests
      @requests ||= []
    end

    def request( params = {}, &block )
      r = Request.new( params, &block )
      requests << r unless requests.include?(r)
      r
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


    def intro( params = {}, &block )
      if params.class == Intro
        o = params
      else
        o = Intro.new( params, &block )
      end
      
      intros << o unless intros.include?(o)
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
