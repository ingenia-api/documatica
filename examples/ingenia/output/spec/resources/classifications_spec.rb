
require 'rest_client'
# 
# Spec for Classifications
#

describe 'Classifications' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Classify' do
    it 'calls Classify' do
      puts "api.ingeniapi.com/v2/classify"

      response = RestClient.post 'api.ingeniapi.com/v2/classify', { :api_key => api_key }.merge( {"api_version"=>nil, "min_tags"=>nil, "max_tags"=>nil, "text"=>"A comparative study of European secondary education systems illustrated issues related to their budgetary sustainability...", "url"=>"http://example.com", "file"=>"document.pdf"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end