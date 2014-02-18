module DocSmoosher
  class ApiObject
    attr_accessor :name, :description

    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end
end