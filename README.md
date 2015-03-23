Doc Smoosher
===

To generate documentaion for ingenia api

goto path/documatica/examples

run ../../bin/smoosher generate

cp output/html/ingenia.html Nowa/app/views/documentation/v2/documentation.html

ta daaa

tl;dr

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

#### Install the stuff

    gem install 'doc_smoosher'

#### Generate a new api scaffold

    smoosher new example_api

#### Edit your API folder

#### Generate!
    cd example_api
    smoosher generate

#### Wow such docs

