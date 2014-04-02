
require 'rest_client'
# 
# Spec for Administrative Calls
#

describe 'Administrative Calls' do
  let(:api_key){ 'YhSysdemYvxqENGrSCHP' }

  describe 'Status' do
    it 'calls Status' do
      puts "api.ingeniapi.com/v2/status"

      response = RestClient.get 'api.ingeniapi.com/v2/status', { :params =>  { :api_key => api_key }.merge( {"total_items"=>"1554", "processed_items"=>"1554", "total_tag_sets"=>"2", "processed_tag_sets"=>"2", "total_tags"=>"167", "processed_tags"=>"167", "ready_to_classify"=>"yes"} )

      
      response.code.should be_okay
      puts response
    end


  end

  describe 'Clear_data' do
    it 'calls Clear_data' do
      puts "api.ingeniapi.com/v2/clear_data"

      response = RestClient.post 'api.ingeniapi.com/v2/clear_data', { :api_key => api_key }.merge( {"item_count"=>"123", "tag_set_count"=>"4", "tag_count"=>"6502"} ) }

      
      response.code.should be_okay
      puts response
    end


  end
 
end