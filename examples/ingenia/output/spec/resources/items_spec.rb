
require 'rest_client'
require 'json'

# 
# Spec for Items
#

describe 'Items' do

  let(:api_key) { "8xnKeWZPzKSiDJSsK45s" }
  let(:json) {  }



  describe 'Index' do
    it 'calls Index' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items',  :params => { :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items',  :params => { :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Show' do
    it 'calls Show' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234',  :params => { :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234',  :params => { :api_key => api_key }  

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234',  :params => { :api_key => api_key }  

        json_response = JSON.parse(response)
        json = json_response['data']

          json[id].class == String
          json[full_text].class == Boolean
      end
  end


  describe 'Create' do
    it 'calls Create' do

      response = RestClient.post 'http://master.test.ingeniapi.com:8080/v2/items', :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post 'http://master.test.ingeniapi.com:8080/v2/items', :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Update' do
    it 'calls Update' do

      response = RestClient.put 'http://master.test.ingeniapi.com:8080/v2/items/1234', :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.put 'http://master.test.ingeniapi.com:8080/v2/items/1234', :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Delete' do
    it 'calls Delete' do

      response = RestClient.delete 'http://master.test.ingeniapi.com:8080/v2/items/1234', :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.delete 'http://master.test.ingeniapi.com:8080/v2/items/1234', :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Similar to' do
    it 'calls Similar to' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234/similar_to',  :params => { :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234/similar_to',  :params => { :api_key => api_key }  

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.get 'http://master.test.ingeniapi.com:8080/v2/items/1234/similar_to',  :params => { :api_key => api_key }  

        json_response = JSON.parse(response)
        json = json_response['data']

          json[id].class == String
          json[mode].class == String
      end
  end
 
end
