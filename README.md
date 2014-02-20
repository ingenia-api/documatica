Doc Smoosher
===
[![Build Status](https://travis-ci.org/dangerousbeans/doc_smoosher.png?branch=master)](https://travis-ci.org/dangerousbeans/doc_smoosher) <-- Yep, that's right.

![BEING_SMOOSHED.jaypurgz](http://i.imgur.com/Fu4YNJa.jpg)

###### A simple API documentation and test generator for the complicated world we live in

#### Turn this
    define_api( name: 'Ingenia API' ) do |api|
      api.description = 'Ingenia analyses your textual...'
      api.endpoint = 'api.ingeniapi.com/v2/'
      api.version = '2.0'
      api.format = 'json'

      api.resource name: 'items' do |r|
        r.description = "Nuggets of textual content..."
        
        r.request name: 'index' do |req|
          req.description = 'An index of all your items'
          req.call_type = :get
          req.path = '/items'

          req.parameter api_key
          req.parameter limit
          req.parameter full_text
          req.parameter offset
        end


        # ....


        r.request name: 'delete' do |req|
          req.description = 'Delete an existing item'
          req.call_type = :delete
          req.path = '/items/:id'

          req.parameter name: 'id' do |p|
            p.description = 'The ID of the item you want to delete.'
            p.type = :string
            p.example = '3casjghd67'
            p.required = true
          end
          req.parameter api_key
        end
      end
    end

#### INTO THIS:
![SUCH_EXAMPLE_WOW.peeeng](http://i.imgur.com/rm1vYj1.png)

## DO IT

Install the stuff

    gem install 'doc_smoosher'

Generate a new api scaffold

    smoosher new example_api

Edit your API folder


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




Define Shared Parameters
===

ruby files in the ./parameters folder are automatically included, so if you setup some variables you can use them all over the rest of your API definition, *to keep things DRY*.

#### example_api/parameters/shared.rb

    ##
    # These guys can be used across your API spec to keep things DRY
    #
    
    @limit = define_parameter( name: 'limit' ) do |p|
      p.description = 'How many results to return'
      p.type = :integer
      p.default = 50
    end

    @offset = define_parameter( name: 'offset' ) do |p|
      p.description = 'Offset returned results by this amount'
      p.type = :integer
    end

    @api_key = define_parameter( name: 'api_key' ) do |p|
      p.description = 'Your API key'
      p.type = :string
      p.required = true
      p.example = "hg7JHG6daSgf56FjhgsSa"
    end

    
    

