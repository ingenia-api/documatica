module DocSmoosher
  class ApiObject
    attr_accessor :name, :description, :example, :type, :required, :default, :footnote, :subtitle

    include DocSmoosher::Parameters

    def initialize(params = {}, &block)
      instance_eval(&block)

      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def this_is_json!
      @as_json = true
    end

		def param_name
		  @as_json ? 'json' : @name
    end
    
    def html_name
      @name.downcase.gsub(/[ \/]/, '-')
    end

    def to_params
      params = {}
      parameters.map{|p| params[p.name] = p.example }

      params
    end

    def test_value
    end

    def matcher
    end
  end
end
