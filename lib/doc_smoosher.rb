require 'rubygems'
require 'bundler/setup'

require 'thor/group'
require 'load_doc_smoosher'


module DocSmoosher

  # DSL methods
  module TopLevel
    def define_api(params = {}, &block)
      api = Api.new( params, &block )
      
      @@api = api
    end

    def define_parameter(params = {}, &block)
      parameter = Parameter.new( params, &block )
      parameters << parameter unless parameters.include?(parameter)
      parameter
    end

    def define_resource(params = {}, &block)
      resource = Resource.new( params, &block )
      resources << resource unless resources.include?(resource)
      resource
    end

    def define_object(params = {}, &block)
      object = ApiObject.new( params, &block )
      objects << object unless resources.include?(object)
      object
    end

    def api
      @@api
    end

    def requests
      @@requests ||= []
    end

    def resources
      @@resources ||= []
    end

    def parameters
      @@parameters ||= []
    end

    def objects
      @@objects ||= []
    end
  end


  TEMPLATES = "../templates"

  # Scan files and folders inside a directory to define an API
  def self.parse_dir directory

  end


  module Generators
    require 'active_support/core_ext'
    require 'active_support/inflector'
    
    class Builder < Thor::Group
      include Thor::Actions

      OUTPUT = './output'

      argument :api, required:  false
      argument :path, default: './'


      def self.source_root
        File.dirname(__FILE__)
      end

      # output directory
      def output
        empty_directory OUTPUT
      end

      def build_api_html
        api_name = File.basename(Dir.getwd)
        api_file = File.join(Dir.getwd, "#{api_name}.rb")

        # load api_file
        puts "opening: #{api_file}"
        File.open(api_file) do |f|
          instance_eval {
            eval f.read
          }
        end

        self.api = @api
#        copy_file(File.join(TEMPLATES, 'html', 'bootstrap.min.css'), "output/html/bootstrap.min.css")
#        copy_file(File.join(TEMPLATES, 'html', 'prettify.css'), "output/html/prettify.css")
#        copy_file(File.join(TEMPLATES, 'html', 'prettify.js'), "output/html/prettify.js")
#        copy_file(File.join(TEMPLATES, 'html', 'run_prettify.js'), "output/html/run_prettify.js")

        template(File.join(TEMPLATES, 'html', 'api.html.erb'), "output/html/#{api_name}.html")
      end
    end

    class Api < Thor::Group
      include Thor::Actions
      argument :name, :type => :string
      argument :description, default: 'Example API'
      # argument :requests, default: [DocSmoosher::Request.new(:name => 'item', :description => 'A unique identifier')]
      # argument :fields, default: [DocSmoosher::Field.new(:name => 'id', :description => 'A unique identifier')]

      class_option :test_framework, :default => :test_unit

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_api
        template(File.join(TEMPLATES, 'api.tt'), "#{name}/#{name}.rb")
        copy_file(File.join(TEMPLATES, 'Readme.md'), "#{name}/Readme.md")
      end

      # %w( resource parameter request ).each do |thing_name|
      #   define_method "#{thing_name}_folder" do
      #     template(File.join(TEMPLATES, "#{thing_name}.tt"), "#{name}/#{thing_name.pluralize}/#{thing_name}_example.rb")
      #   end
      # end

      def done_message
        message = <<MESSAGE
    
    Scaffolding all built and ready!

    You now need to edit the example files/folders to setup the shape of your API, so you can generate documentation around it magically.

    Thanks for using doc_smoosher. Now smoosh them APIs gurd.  -  Joran Kikke  -  @donkeyscience
MESSAGE

        puts message
      end
    end
  end
end
