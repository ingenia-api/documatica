This is your API definition file, setup stuff here

Setup API Basics
===
#### example_api/example_api.rb

    require 'bundler/setup'
    require 'doc_smoosher'

    extend DocSmoosher::TopLevel

    load 'parameters/shared.rb'

    define_api name: 'ingenia' do |api|
      api.description = 'Example API'
      api.endpoint = 'http://api.ingeniapi.com'
      api.version = '2.0'
      api.format = 'json'

      api.resource name: 'item' do |r|
        r.description = "A text item"
    
        r.request name: 'index' do |req|
          req.description = 'An index of all your items'
          req.call_type = :get
          req.path = '/items'

      req.parameter name: 'full_text' do |p|
        p.description = 'Should the results be shown with all their text'
            p.type = :boolean
            p.default = false
      end

      # includes shared parameters
          req.parameter(@api_key)
          req.parameter(@limit)
          req.parameter(@offset)
        end
      end
    end

    # Output api as json
    puts api.to_json


Generate!
===
   cd example_api
   smoosher generate
   