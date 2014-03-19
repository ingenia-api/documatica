module DocSmoosher
  class Field < ApiObject
    attr_accessor :required, :min, :max, :example, :default, :type

    def initialize(params = {}, &block)
      # Defaults
      self.required = false

      super
    end
  end
end
