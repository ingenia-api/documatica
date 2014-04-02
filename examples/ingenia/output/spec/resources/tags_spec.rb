
require 'rest_client'
# 
# Spec for Tags
#

describe 'Tags' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      puts "api.ingeniapi.com/v2/tags"

      response = RestClient.get 'api.ingeniapi.com/v2/tags', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "offset"=>nil} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Show' do
    it 'calls Show' do
      puts "api.ingeniapi.com/v2/tags/:id"

      response = RestClient.get 'api.ingeniapi.com/v2/tags/:id', { :params =>  { :api_key => api_key }.merge( {"id"=>"42"} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/tags/:id', { :params =>  { :api_key => api_key } }

      
      response.should == '{"name"=>nil, "tag_set_id"=>"3787", "confidence"=>nil, "consistency"=>nil, "description"=>nil, "disposition"=>0.75}'
    end

  end

  describe 'Find_by_name' do
    it 'calls Find_by_name' do
      puts "api.ingeniapi.com/v2/tags/find_by_name"

      response = RestClient.get 'api.ingeniapi.com/v2/tags/find_by_name', { :params =>  { :api_key => api_key }.merge( {"text"=>"\"Tech Startups\""} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Create' do
    it 'calls Create' do
      puts "api.ingeniapi.com/v2/tags"

      response = RestClient.post 'api.ingeniapi.com/v2/tags', { :api_key => api_key }.merge( {"Tag create / update input"=>"\n  {\n    \"name\":\"Text Analytics\",\n    \"tag_set_id\":37874,\n    \"description\":\"\",\n    \"disposition\": 0.3\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Update' do
    it 'calls Update' do
      puts "api.ingeniapi.com/v2/tags/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/tags/:id', { :api_key => api_key }.merge( {"id"=>"42", "Tag create / update input"=>"\n  {\n    \"name\":\"Text Analytics\",\n    \"tag_set_id\":37874,\n    \"description\":\"\",\n    \"disposition\": 0.3\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Merge' do
    it 'calls Merge' do
      puts "api.ingeniapi.com/v2/tags/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/tags/:id', { :api_key => api_key }.merge( {"id"=>"42", "tag_ids"=>"[ 23, 43, 2113 ]"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Delete' do
    it 'calls Delete' do
      puts "api.ingeniapi.com/v2/tags/:id"

      response = RestClient.delete 'api.ingeniapi.com/v2/tags/:id', { :api_key => api_key }.merge( {"id"=>"42"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end