
require 'rest_client'
require 'json'

# 
# Spec for Recommendation engine
#

describe 'Recommendation engine' do




  describe 'Similar to text' do
    it 'calls Similar to text' do

      response = RestClient.post '/similar_to_text', :limit => limit, :full_text => full_text, :text => text, :mode => mode, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/similar_to_text', :limit => limit, :full_text => full_text, :text => text, :mode => mode, :api_key => api_key 

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.post '/similar_to_text', :limit => limit, :full_text => full_text, :text => text, :mode => mode, :api_key => api_key 

        json_response = JSON.parse(response)
        json = json_response['data']

          json[limit].class == Fixnum
          json[full_text].class == Boolean
          json[text].class == String
          json[mode].class == String
      end
  end


  describe 'Similar to tags' do
    it 'calls Similar to tags' do

      response = RestClient.get '/similar_to_tags',  :params => { :limit => limit, :full_text => full_text, :tag_ids => tag_ids, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/similar_to_tags',  :params => { :limit => limit, :full_text => full_text, :tag_ids => tag_ids, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.get '/similar_to_tags',  :params => { :limit => limit, :full_text => full_text, :tag_ids => tag_ids, :api_key => api_key }  

        json_response = JSON.parse(response)
        json = json_response['data']

          json[limit].class == Fixnum
          json[full_text].class == Boolean
          json[tag_ids]
      end
  end
 
end
