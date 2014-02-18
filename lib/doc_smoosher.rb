require 'thor/group'
require 'load_doc_smoosher'


module DocSmoosher

  # DSL methods
  module TopLevel
    def define_api(api_name, &block)
      Api.define_api( &block )
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

      argument :path, default: './'

      def api
        puts "api"
        api_name = File.basename(Dir.getwd)
        api_file = File.join(Dir.getwd, "#{api_name}.rb")

        require api_file
      end

      def entities
        puts "entities"
      end
    end

    class Api < Thor::Group
      include Thor::Actions
      argument :name, :type => :string
      argument :description, default: 'Example API'
      argument :requests, default: [DocSmoosher::Request.new(:name => 'item', :description => 'A unique identifier')]
      argument :fields, default: [DocSmoosher::Field.new(:name => 'id', :description => 'A unique identifier')]

      class_option :test_framework, :default => :test_unit

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_api
        template(File.join(TEMPLATES, 'api.tt'), "#{name}/#{name}.rb")
      end

      %w( entity parameter request ).each do |thing_name|
        define_method "#{thing_name}_folder" do
          template(File.join(TEMPLATES, "#{thing_name}.tt"), "#{name}/#{thing_name.pluralize}/#{thing_name}_example.rb")
        end
      end

      def done_message
        message = <<MESSAGE
    
    Scaffolding all built and ready!

    You now need to edit the example files/folders to setup the shape of your API, so you can generate documentation and specs around it magically.

    Thanks for using doc_smoosher. Now smoosh them APIs gurd.   - Joran Kikke - @donkeyscience
MESSAGE

        puts message
      end
    end
  end
end