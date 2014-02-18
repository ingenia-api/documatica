module DocSmoosher
  class Api < ApiObject
    attr_accessor :description, :endpoint, :version, :format

    def initialize(params = {}, &block)
      instance_eval &block

      super(params)
    end
  end
end