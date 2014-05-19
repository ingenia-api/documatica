
require 'rest_client'
require 'json'

# 
# Spec for Bundles
#

describe 'Bundles' do




  describe 'Index' do
    it 'calls Index' do

      response = RestClient.get '/bundles',  :params => { :limit => limit, :offset => offset, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/bundles',  :params => { :limit => limit, :offset => offset, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Show' do
    it 'calls Show' do

      response = RestClient.get '/bundles/:id',  :params => { :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/bundles/:id',  :params => { :api_key => api_key }  

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.get '/bundles/:id',  :params => { :api_key => api_key }  

        json_response = JSON.parse(response)
        json = json_response['data']

          json[id].class == Fixnum
      end
  end


  describe 'Find_by_name' do
    it 'calls Find_by_name' do

      response = RestClient.get '/bundles/find_by_name',  :params => { :text => text, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/bundles/find_by_name',  :params => { :text => text, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Create' do
    it 'calls Create' do

      response = RestClient.post '/bundles', :Bundle create / update input => Bundle create / update input, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/bundles', :Bundle create / update input => Bundle create / update input, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Update' do
    it 'calls Update' do

      response = RestClient.put '/bundles/:id', :Bundle create / update input => Bundle create / update input, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.put '/bundles/:id', :Bundle create / update input => Bundle create / update input, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Delete' do
    it 'calls Delete' do

      response = RestClient.delete '/bundles/:id', :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.delete '/bundles/:id', :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end
 
end
