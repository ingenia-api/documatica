
require 'rest_client'
require 'json'

# 
# Spec for Administrative Calls
#

describe 'Administrative Calls' do




  describe 'Status' do
    it 'calls Status' do

      response = RestClient.get '/status',  :params => { :total_bundles => total_bundles, :total_items => total_items, :processed_items => processed_items, :total_tag_sets => total_tag_sets, :processed_tag_sets => processed_tag_sets, :total_tags => total_tags, :processed_tags => processed_tags, :ready_to_classify => ready_to_classify, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/status',  :params => { :total_bundles => total_bundles, :total_items => total_items, :processed_items => processed_items, :total_tag_sets => total_tag_sets, :processed_tag_sets => processed_tag_sets, :total_tags => total_tags, :processed_tags => processed_tags, :ready_to_classify => ready_to_classify, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Clear_data' do
    it 'calls Clear_data' do

      response = RestClient.post '/clear_data', :item_count => item_count, :tag_set_count => tag_set_count, :tag_count => tag_count, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/clear_data', :item_count => item_count, :tag_set_count => tag_set_count, :tag_count => tag_count, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end
 
end
