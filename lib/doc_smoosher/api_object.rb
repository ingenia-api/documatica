module DocSmoosher
  class ApiObject
    attr_accessor :name, :description

    include DocSmoosher::Parameters

    def initialize(params = {}, &block)
      instance_eval(&block)

      params.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end
end