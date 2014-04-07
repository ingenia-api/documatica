
require 'rest_client'
require 'json'
# 
# Spec for Classifications
#

describe 'Classifications' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Classify' do
    it 'calls Classify' do
      response = RestClient.post 'api.ingeniapi.com/v2/classify', { :api_key => api_key }.merge( {"api_version"=>42, "min_tags"=>42, "max_tags"=>42, "text"=>"example string", "url"=>"example string", "file"=>nil} ) 

      response.code.should eq(200)
    end

    it 'responds with JSON' do
      response = RestClient.post 'api.ingeniapi.com/v2/classify', { :api_key => api_key }.merge( {"api_version"=>42, "min_tags"=>42, "max_tags"=>42, "text"=>"example string", "url"=>"example string", "file"=>nil} ) 

      JSON.parse(response).should be_true
    end

  end
 
end