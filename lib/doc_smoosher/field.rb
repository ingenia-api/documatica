module DocSmoosher
  class Field
    attr_accessor :name, :description, :required

    def initialize params = {}
      self.name = params[:name]
      self.description = params[:description]
      self.required = params[:required]
    end
  end
end
