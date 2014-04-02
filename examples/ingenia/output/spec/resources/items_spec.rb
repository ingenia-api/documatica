
require 'rest_client'
# 
# Spec for Items
#

describe 'Items' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      puts "api.ingeniapi.com/v2/items"

      response = RestClient.get 'api.ingeniapi.com/v2/items', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "full_text"=>nil, "offset"=>nil} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Show' do
    it 'calls Show' do
      puts "api.ingeniapi.com/v2/items/:id"

      response = RestClient.get 'api.ingeniapi.com/v2/items/:id', { :params =>  { :api_key => api_key }.merge( {"id"=>"3casjghd67", "full_text"=>nil} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/items/:id', { :params =>  { :api_key => api_key } }

      
      response.should == '{"id"=>"785uU423aC", "text"=>nil, "created_at"=>"2013-12-16T11:24:52+00:00", "updated_at"=>"2013-12-16T11:25:52+00:00", "last_classified_at"=>"2013-12-16T11:25:52+00:00"}'
    end

  end

  describe 'Create' do
    it 'calls Create' do
      puts "api.ingeniapi.com/v2/items"

      response = RestClient.post 'api.ingeniapi.com/v2/items', { :api_key => api_key }.merge( {"file"=>nil, "update_existing"=>nil, "classify"=>nil, "Item create / update input"=>"\n  {\n    text: \"High tech startups and their positive power to change for the good\",\n    tag_sets: {\n      \"Business\": [ \"startups\", \"business\" ],\n      \"Economics\": [ \"technology\"],\n      \"Mood\": [ \"positive\" ]\n    }\n  }\n  "} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Update' do
    it 'calls Update' do
      puts "api.ingeniapi.com/v2/items/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"3casjghd67", "file"=>nil, "Item create / update input"=>"\n  {\n    text: \"High tech startups and their positive power to change for the good\",\n    tag_sets: {\n      \"Business\": [ \"startups\", \"business\" ],\n      \"Economics\": [ \"technology\"],\n      \"Mood\": [ \"positive\" ]\n    }\n  }\n  "} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Delete' do
    it 'calls Delete' do
      puts "api.ingeniapi.com/v2/items/:id"

      response = RestClient.delete 'api.ingeniapi.com/v2/items/:id', { :api_key => api_key }.merge( {"id"=>"3casjghd67"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end