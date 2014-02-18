module DocSmoosher
  class Api < ApiObject
    attr_accessor :description, :endpoint, :version, :format

    def self.define_api(&block)
      puts "API: define_api"
      
    end
  end
end