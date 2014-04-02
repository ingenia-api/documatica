
require 'rest_client'
# 
# Spec for Tag sets
#

describe 'Tag sets' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Index' do
    it 'calls Index' do
      puts "api.ingeniapi.com/v2/tag_sets"

      response = RestClient.get 'api.ingeniapi.com/v2/tag_sets', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "offset"=>nil} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Show' do
    it 'calls Show' do
      puts "api.ingeniapi.com/v2/tag_sets/:id"

      response = RestClient.get 'api.ingeniapi.com/v2/tag_sets/:id', { :params =>  { :api_key => api_key }.merge( {"id"=>"412"} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/tag_sets/:id', { :params =>  { :api_key => api_key } }

      
      response.should == '{"name"=>nil}'
    end

  end

  describe 'Find_by_name' do
    it 'calls Find_by_name' do
      puts "api.ingeniapi.com/v2/tag sets/find_by_name"

      response = RestClient.get 'api.ingeniapi.com/v2/tag sets/find_by_name', { :params =>  { :api_key => api_key }.merge( {"text"=>"\"Tech Startups\""} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Create' do
    it 'calls Create' do
      puts "api.ingeniapi.com/v2/tag_sets"

      response = RestClient.post 'api.ingeniapi.com/v2/tag_sets', { :api_key => api_key }.merge( {"Tag set create / update input"=>"\n  {\n    \"name\":\"Big Data\"\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Update' do
    it 'calls Update' do
      puts "api.ingeniapi.com/v2/tag_sets/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>"412", "Tag set create / update input"=>"\n  {\n    \"name\":\"Big Data\"\n  }"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Merge' do
    it 'calls Merge' do
      puts "api.ingeniapi.com/v2/tag_sets/:id"

      response = RestClient.put 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>"412", "tag_set_ids"=>"[ 12, 34, 56 ]"} ) }

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Delete' do
    it 'calls Delete' do
      puts "api.ingeniapi.com/v2/tag_sets/:id"

      response = RestClient.delete 'api.ingeniapi.com/v2/tag_sets/:id', { :api_key => api_key }.merge( {"id"=>"412"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end