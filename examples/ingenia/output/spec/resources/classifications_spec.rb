
require 'rest_client'
require 'json'

# 
# Spec for Classifications
#

describe 'Classifications' do




  describe 'Classify' do
    it 'calls Classify' do

      response = RestClient.post '/classify', :api_version => api_version, :min_tags => min_tags, :max_tags => max_tags, :text => text, :url => url, :file => file, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/classify', :api_version => api_version, :min_tags => min_tags, :max_tags => max_tags, :text => text, :url => url, :file => file, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end
 
end
