module DocSmoosher
  class Api
    attr_accessor :description, :endpoint, :version, :format

    def define_api
      yield
    end
  end
end