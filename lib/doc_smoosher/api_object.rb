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

		def name
		  
		  case @name
		  when 'item' then 'json'
		  when 'tag_set' then 'json'
 		  when 'bundle' then 'json'
 		  when 'tag' then 'json'
 		  else @name
 		  end
    end
    
    def name2
      @name
    end
    
  end
end
