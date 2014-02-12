require 'thor/group'
require 'load_doc_smoosher'

module DocSmoosher

  TEMPLATES = "../templates"

  # Scan files and folders inside a directory to define an API
  def self.parse_dir directory

  end


  module Generators
    class Api < Thor::Group

      require 'active_support/core_ext'
      require 'active_support/inflector'

      include Thor::Actions
      argument :name, :type => :string
      
      class_option :test_framework, :default => :test_unit

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_api
        template(File.join(TEMPLATES, 'api.tt'), "#{name}/#{name}.rb")
      end

      %w( entity field request ).each do |thing_name|
        define_method "#{thing_name}_folder" do
          template(File.join(TEMPLATES, "#{thing_name}.tt"), "#{name}/#{thing_name.pluralize}/example.rb")
        end
      end

    end
  end
end