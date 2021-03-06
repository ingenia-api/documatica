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

  end
end
