
require 'rest_client'
require 'json'
# 
# Spec for Summarization
#

describe 'Summarization' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Summarise' do
    it 'calls Summarise' do
      response = RestClient.post 'api.ingeniapi.com/v2/summarise', { :api_key => api_key }.merge( {"text"=>"example string", "include_tags"=>true, "max_sentences"=>42, "order_by_position"=>true} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.post 'api.ingeniapi.com/v2/summarise', { :api_key => api_key }.merge( {"text"=>"example string", "include_tags"=>true, "max_sentences"=>42, "order_by_position"=>true} ) 

      JSON.parse(response).should be_true
    end

  end
 
end