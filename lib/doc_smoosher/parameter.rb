module DocSmoosher
  class Parameter < ApiObject
    attr_accessor :required, :min, :max, :default, :type, :example

    def matcher
      case type

      when :string
        '.class == String'

      when :float
        '.class == Float'

      when :integer
        '.class == Fixnum'
      when :boolean
        '.class == Boolean'

      when :date_time
        ''
      end
    end

    def test_value
      case type

      when :string
        "example string"

      when :float
        1.45

      when :integer
        v = 42
        v = [42, max].min if max
        v = [v, min].max if min
        v
      when :boolean
        true

      when :date_time
        '2013-12-16T11:25:52+00:00'

      end
    end
  end
end
