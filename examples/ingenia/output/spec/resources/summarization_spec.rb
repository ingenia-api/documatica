
require 'rest_client'
# 
# Spec for Summarization
#

describe 'Summarization' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Summarise' do
    it 'calls Summarise' do
      puts "api.ingeniapi.com/v2/summarise"

      response = RestClient.post 'api.ingeniapi.com/v2/summarise', { :api_key => api_key }.merge( {"text"=>nil, "include_tags"=>nil, "max_sentences"=>nil, "order_by_position"=>nil} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end