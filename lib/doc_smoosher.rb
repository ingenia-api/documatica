require 'thor/group'
require_relative 'doc_smoosher/api'

module DocSmoosher

  # Scan files and folders inside a directory to define an API
  def self.parse_dir directory

  end


  module Generators
    class Api < Thor::Group
      include Thor::Actions
      argument :name, :type => :string
      
      class_option :test_framework, :default => :test_unit

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_api_dir

        puts "creating app dir"
        create_file name
      end
    end
  end


  # def self.help
  #   puts 'Useage: '
  #   puts '    smoosher generate NewApiName'
  #   puts '      - Builds a new scaffold template called NewApiName for your API'
  # end

end