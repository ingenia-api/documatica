
require 'rest_client'
require 'json'

# 
# Spec for Summarization
#

describe 'Summarization' do




  describe 'Summarise' do
    it 'calls Summarise' do

      response = RestClient.post '/summarise', :text => text, :include_tags => include_tags, :max_sentences => max_sentences, :order_by_position => order_by_position, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/summarise', :text => text, :include_tags => include_tags, :max_sentences => max_sentences, :order_by_position => order_by_position, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end
 
end
