
require 'rest_client'
require 'json'
# 
# Spec for Items
#

describe 'Items' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      response = RestClient.get "api.ingeniapi.com/v2/items?api_key=#{ api_key }", { :params =>  {"limit"=>42, "full_text"=>true, "offset"=>42} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/items?api_key=#{ api_key }", { :params =>  {"limit"=>42, "full_text"=>true, "offset"=>42} }

      JSON.parse(response).should be_true
    end

  end
  describe 'Show' do
    it 'calls Show' do
      response = RestClient.get "api.ingeniapi.com/v2/items/:id?api_key=#{ api_key }", { :params =>  {"id"=>"example string", "full_text"=>true} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/items/:id?api_key=#{ api_key }", { :params =>  {"id"=>"example string", "full_text"=>true} }

      JSON.parse(response).should be_true
    end

    it 'responds as expected' do
      response = RestClient.get "api.ingeniapi.com/v2/items/1?api_key=#{ api_key }", { :params =>  {"id"=>"example string", "full_text"=>true} }

      json_response = JSON.parse(response)
      json = json_response['data']

      json[id].class == String
      json[full_text].class == Boolean
    end
  end
  describe 'Create' do
    it 'calls Create' do
      response = RestClient.post 'api.ingeniapi.com/v2/items', { :api_key => api_key }.merge( {"file"=>nil, "update_existing"=>nil, "classify"=>nil, "Item create / update input"=>nil} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.post 'api.ingeniapi.com/v2/items', { :api_key => api_key }.merge( {"file"=>nil, "update_existing"=>nil, "classify"=>nil, "Item create / update input"=>nil} ) 

      JSON.parse(response).should be_true
    end

  end
  describe 'Update' do
    it 'calls Update' do
      response = RestClient.put 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"example string", "file"=>nil, "Item create / update input"=>nil} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.put 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"example string", "file"=>nil, "Item create / update input"=>nil} ) 

      JSON.parse(response).should be_true
    end

  end
  describe 'Delete' do
    it 'calls Delete' do
      response = RestClient.delete 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"example string"} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.delete 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"example string"} ) 

      JSON.parse(response).should be_true
    end

  end
 
end