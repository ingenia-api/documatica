require 'thor/group'
require_relative 'doc_smoosher/api'

module DocSmoosher

  # Scan files and folders inside a directory to define an API
  def self.parse_dir directory

  end


  module Generators
    class Recipe < Thor::Group
      include Thor::Actions

      argument :name, :type => :string
    end
  end


  def self.help
    puts 'Useage: '
    puts '    smoosher generate NewApiName'
    puts '      - Builds a new scaffold template called NewApiName for your API'
  end

end