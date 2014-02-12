# require 'doc_smoosher'

# Define the API and it's basic properties
DocSmoosher.define_api 'Ingenia' do
  description 'Ingenia analyses your textual content and automatically categorises it using your own tags.'
  endpoint 'api.ingeniapi.com/v2/'
  field :version, 2.0
  field :format, :json
end