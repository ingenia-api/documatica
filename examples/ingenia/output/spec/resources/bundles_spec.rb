
require 'rest_client'
# 
# Spec for Bundles
#

describe 'Bundles' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      puts "api.ingeniapi.com/v2/bundles"

      response = RestClient.get 'api.ingeniapi.com/v2/bundles', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "offset"=>nil} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Show' do
    it 'calls Show' do
      puts "api.ingeniapi.com/v2/bundles/:id"

      response = RestClient.get 'api.ingeniapi.com/v2/bundles/:id', { :params =>  { :api_key => api_key }.merge( {"id"=>2314} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/bundles/:id', { :params =>  { :api_key => api_key } }

      
      response.should == '{"name"=>nil, "tag_sets"=>nil}'
    end

  end

  describe 'Find_by_name' do
    it 'calls Find_by_name' do
      puts "api.ingeniapi.com/v2/bundles/find_by_name"

      response = RestClient.get 'api.ingeniapi.com/v2/bundles/find_by_name', { :params =>  { :api_key => api_key }.merge( {"text"=>"\"Tech Startups\""} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Create' do
    it 'calls Create' do
      puts "api.ingeniapi.com/v2/bundles"

      response = RestClient.post 'api.ingeniapi.com/v2/bundles', { :api_key => api_key }.merge( {"Bundle create / update input"=>"\n  {\n    \"name\":\"Tech Startups\",\n    \"tag_set_ids\": [ 232, 332, 6582 ]\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Update' do
    it 'calls Update' do
      puts "api.ingeniapi.com/v2/bundles/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/bundles/:id', { :api_key => api_key }.merge( {"id"=>5611, "Bundle create / update input"=>"\n  {\n    \"name\":\"Tech Startups\",\n    \"tag_set_ids\": [ 232, 332, 6582 ]\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Delete' do
    it 'calls Delete' do
      puts "api.ingeniapi.com/v2/bundles/:id"

      response = RestClient.delete 'api.ingeniapi.com/v2/bundles/:id', { :api_key => api_key }.merge( {"id"=>"gqj78219nc"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end