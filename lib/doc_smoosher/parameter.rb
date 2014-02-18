module DocSmoosher
  class Parameter < ApiObject
    attr_accessor :required, :min, :max, :example, :default, :type, :example

    def initialize(params = {}, &block)
      # Defaults
      self.required = false

      super(params)
    end

  end
end