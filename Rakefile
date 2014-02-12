# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "doc_smoosher"
  gem.homepage = "http://github.com/dangerousbeans/doc_smoosher"
  gem.license = "MIT"
  gem.summary = %Q{ A simple API documentation generator for the complicated world we live in }
  gem.description = %Q{ A simple API documentation generator for the complicated world we live in }
  gem.email = "joran.k@gmail.com"
  gem.authors = ["Joran Kikke"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "doc_smoosher #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



namespace :ds do
  desc "Scan an API"
  task :scan_url do
    require 'rest-client'

    puts 'missing URL' if ENV['URL'].nil?
    puts 'missing API_KEY' if ENV['API_KEY'].nil?

  end

  desc "Generate from a directory"
  task :generate do
    require 'bundler/setup'
    require_relative 'lib/doc_smoosher'

    if ENV['DIR'].nil?
      puts 'missing DIR'
      next
    end

    dir = ENV['DIR']

    api_name = File.split(dir).last
    api_file_name = api_name + '.rb'

    puts "Generating from: #{dir}"
    puts "API Name: #{api_name}"
    puts "Loading: #{api_file_name}"

    require File.join(dir, api_file_name)
  end

  task :create, :project_name do |t, args|
    puts args
  end
end