
require 'rest_client'
require 'json'
# 
# Spec for Administrative Calls
#

describe 'Administrative Calls' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Status' do
    it 'calls Status' do
      response = RestClient.get "api.ingeniapi.com/v2/status?api_key=#{ api_key }", { :params =>  {"total_items"=>42, "processed_items"=>42, "total_tag_sets"=>42, "processed_tag_sets"=>42, "total_tags"=>42, "processed_tags"=>42, "ready_to_classify"=>true} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/status?api_key=#{ api_key }", { :params =>  {"total_items"=>42, "processed_items"=>42, "total_tag_sets"=>42, "processed_tag_sets"=>42, "total_tags"=>42, "processed_tags"=>42, "ready_to_classify"=>true} }

      JSON.parse(response).should be_true
    end

  end
  describe 'Clear_data' do
    it 'calls Clear_data' do
      response = RestClient.post 'api.ingeniapi.com/v2/clear_data', { :api_key => api_key }.merge( {"item_count"=>42, "tag_set_count"=>42, "tag_count"=>42} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.post 'api.ingeniapi.com/v2/clear_data', { :api_key => api_key }.merge( {"item_count"=>42, "tag_set_count"=>42, "tag_count"=>42} ) 

      JSON.parse(response).should be_true
    end

  end
 
end