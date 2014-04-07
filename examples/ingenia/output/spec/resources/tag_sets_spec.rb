
require 'rest_client'
require 'json'
# 
# Spec for Tag sets
#

describe 'Tag sets' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      response = RestClient.get "api.ingeniapi.com/v2/tag_sets?api_key=#{ api_key }", { :params =>  {"limit"=>42, "offset"=>42} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/tag_sets?api_key=#{ api_key }", { :params =>  {"limit"=>42, "offset"=>42} }

      JSON.parse(response).should be_true
    end

  end
  describe 'Show' do
    it 'calls Show' do
      response = RestClient.get "api.ingeniapi.com/v2/tag_sets/:id?api_key=#{ api_key }", { :params =>  {"id"=>42} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/tag_sets/:id?api_key=#{ api_key }", { :params =>  {"id"=>42} }

      JSON.parse(response).should be_true
    end

    it 'responds as expected' do
      response = RestClient.get "api.ingeniapi.com/v2/tag_sets/:id?api_key=#{ api_key }", { :params =>  {"id"=>42} }

      json_response = JSON.parse(response)
      json = json_response['data']

      json[id].class == Fixnum
    end
  end
  describe 'Find_by_name' do
    it 'calls Find_by_name' do
      response = RestClient.get "api.ingeniapi.com/v2/tag sets/find_by_name?api_key=#{ api_key }", { :params =>  {"text"=>"example string"} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/tag sets/find_by_name?api_key=#{ api_key }", { :params =>  {"text"=>"example string"} }

      JSON.parse(response).should be_true
    end

  end
  describe 'Create' do
    it 'calls Create' do
      response = RestClient.post 'api.ingeniapi.com/v2/tag_sets', { :api_key => api_key }.merge( {"Tag set create / update input"=>nil} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.post 'api.ingeniapi.com/v2/tag_sets', { :api_key => api_key }.merge( {"Tag set create / update input"=>nil} ) 

      JSON.parse(response).should be_true
    end

  end
  describe 'Update' do
    it 'calls Update' do
      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42, "Tag set create / update input"=>nil} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42, "Tag set create / update input"=>nil} ) 

      JSON.parse(response).should be_true
    end

  end
  describe 'Merge' do
    it 'calls Merge' do
      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42, "tag_set_ids"=>42} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42, "tag_set_ids"=>42} ) 

      JSON.parse(response).should be_true
    end

  end
  describe 'Delete' do
    it 'calls Delete' do
      response = RestClient.delete 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.delete 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>42} ) 

      JSON.parse(response).should be_true
    end

  end
 
end