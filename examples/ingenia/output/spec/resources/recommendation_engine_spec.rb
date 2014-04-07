
require 'rest_client'
require 'json'
# 
# Spec for Recommendation engine
#

describe 'Recommendation engine' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Similar_to_text' do
    it 'calls Similar_to_text' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_text?api_key=#{ api_key }", { :params =>  {"limit"=>42, "full_text"=>42, "text"=>"example string"} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_text?api_key=#{ api_key }", { :params =>  {"limit"=>42, "full_text"=>42, "text"=>"example string"} }

      JSON.parse(response).should be_true
    end

    it 'responds as expected' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_text?api_key=#{ api_key }", { :params =>  {"limit"=>42, "full_text"=>42, "text"=>"example string"} }

      json_response = JSON.parse(response)
      json = json_response['data']

      json[limit].class == Fixnum
      json[full_text].class == Fixnum
      json[text].class == String
    end
  end
  describe 'Similar_to_tags' do
    it 'calls Similar_to_tags' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_tags?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "tag_ids"=>nil} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_tags?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "tag_ids"=>nil} }

      JSON.parse(response).should be_true
    end

    it 'responds as expected' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_tags?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "tag_ids"=>nil} }

      json_response = JSON.parse(response)
      json = json_response['data']

      json[limit].class == Fixnum
      json[tag_set_count].class == Fixnum
      json[tag_ids]
    end
  end
  describe 'Similar_to_items' do
    it 'calls Similar_to_items' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_item?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "item_ids"=>nil} }

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_item?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "item_ids"=>nil} }

      JSON.parse(response).should be_true
    end

    it 'responds as expected' do
      response = RestClient.get "api.ingeniapi.com/v2/similar_to_item?api_key=#{ api_key }", { :params =>  {"limit"=>42, "tag_set_count"=>42, "item_ids"=>nil} }

      json_response = JSON.parse(response)
      json = json_response['data']

      json[limit].class == Fixnum
      json[tag_set_count].class == Fixnum
      json[item_ids]
    end
  end
 
end