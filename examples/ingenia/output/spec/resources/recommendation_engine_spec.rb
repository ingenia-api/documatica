
require 'rest_client'
# 
# Spec for Recommendation engine
#

describe 'Recommendation engine' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Similar_to_text' do
    it 'calls Similar_to_text' do
      puts "api.ingeniapi.com/v2/similar_to_text"

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_text', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "full_text"=>nil, "text"=>nil} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_text', { :params =>  { :api_key => api_key } }

      
      response.should == '{"id"=>nil, "text"=>nil, "mode"=>nil, "similarity"=>nil}'
    end

  end

  describe 'Similar_to_tags' do
    it 'calls Similar_to_tags' do
      puts "api.ingeniapi.com/v2/similar_to_tags"

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_tags', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "tag_set_count"=>nil, "tag_ids"=>nil} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_tags', { :params =>  { :api_key => api_key } }

      
      response.should == '{"id"=>nil, "text"=>nil, "mode"=>nil, "similarity"=>nil}'
    end

  end

  describe 'Similar_to_items' do
    it 'calls Similar_to_items' do
      puts "api.ingeniapi.com/v2/similar_to_item"

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_item', { :params =>  { :api_key => api_key }.merge( {"limit"=>nil, "tag_set_count"=>nil, "item_ids"=>nil} )

      
      response.code.should be_okay
      puts response
    end


    it 'responds as expected' do

      response = RestClient.get 'api.ingeniapi.com/v2/similar_to_item', { :params =>  { :api_key => api_key } }

      
      response.should == '{"id"=>nil, "text"=>nil, "mode"=>nil, "similarity"=>nil}'
    end

  end
 
end