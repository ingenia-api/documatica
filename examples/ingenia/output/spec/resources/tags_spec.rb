
require 'rest_client'
require 'json'

# 
# Spec for Tags
#

describe 'Tags' do




  describe 'Index' do
    it 'calls Index' do

      response = RestClient.get '/tags',  :params => { :limit => limit, :offset => offset, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/tags',  :params => { :limit => limit, :offset => offset, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Show' do
    it 'calls Show' do

      response = RestClient.get '/tags/:id',  :params => { :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/tags/:id',  :params => { :api_key => api_key }  

      JSON.parse(response).should be_true
    end

      it 'responds as expected' do

      response = RestClient.get '/tags/:id',  :params => { :api_key => api_key }  

        json_response = JSON.parse(response)
        json = json_response['data']

          json[id].class == Fixnum
      end
  end


  describe 'Find_by_name' do
    it 'calls Find_by_name' do

      response = RestClient.get '/tags/find_by_name',  :params => { :text => text, :api_key => api_key }  

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.get '/tags/find_by_name',  :params => { :text => text, :api_key => api_key }  

      JSON.parse(response).should be_true
    end

  end


  describe 'Create' do
    it 'calls Create' do

      response = RestClient.post '/tags', :Tag create / update input => Tag create / update input, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.post '/tags', :Tag create / update input => Tag create / update input, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Update' do
    it 'calls Update' do

      response = RestClient.put '/tags/:id', :Tag create / update input => Tag create / update input, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.put '/tags/:id', :Tag create / update input => Tag create / update input, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Merge' do
    it 'calls Merge' do

      response = RestClient.put '/tags/:id', :tag_ids => tag_ids, :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.put '/tags/:id', :tag_ids => tag_ids, :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end


  describe 'Delete' do
    it 'calls Delete' do

      response = RestClient.delete '/tags/:id', :api_key => api_key 

      response.code.should eq(200)
    end

    it 'responds with JSON' do

      response = RestClient.delete '/tags/:id', :api_key => api_key 

      JSON.parse(response).should be_true
    end

  end
 
end
