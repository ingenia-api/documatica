module DocSmoosher
  class Intro
    attr_accessor :description, :name

    include DocSmoosher::Parameters

    def initialize(params = {}, &block)
      instance_eval(&block)

      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
    
    def name
      
      case @name
        when 'intro' then json
        else @name 
      end

    end

  end
end
