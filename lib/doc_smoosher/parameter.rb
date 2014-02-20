module DocSmoosher
  class Parameter < ApiObject
    attr_accessor :required, :min, :max, :default, :type, :example
  end
end