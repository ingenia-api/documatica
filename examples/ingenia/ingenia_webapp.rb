require 'bundler/setup'
require 'sinatra'

##
# Example web server
#
get '/' do
  content_type :json

  File.open('ingenia.rb') do |f|
    eval(f.read)
  end
end
