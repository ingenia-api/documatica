$LOAD_PATH << '.'
require 'bundler/setup'
require 'doc_smoosher'

extend DocSmoosher::TopLevel

##
# This file defined the APIs primary attributes, along with what requests it can handle
#

#
# Shared fields
#

# limit = define_parameter( name: 'limit' ) do |p|
#   p.description = 'How many results to return'
#   p.type = :integer
#   p.default = 50
# end
# 
# offset = define_parameter( name: 'offset' ) do |p|
#   p.description = 'Offset returned results by this amount'
#   p.type = :integer
#   p.default = 0
# end
# 
# api_key = define_parameter( name: 'api_key' ) do |p|
#   p.description = 'Your API key'
#   p.type = :string
#   p.required = true
#   p.example = "hg7JHG6daSgf56FjhgsSa"
# end


#
# Shared API Objects
#

# json_item = define_object( name: 'item' ) do |item|
#   item.description = "A text item"
#   item.parameter name: 'text' do |p|
#     p.description = 'Your item\'s content'
#     p.type = :string
#     p.max = 50_000
#   end

#   item.parameter name: 'id' do |p|
#     p.description = 'Custom text/numeric id. This can be used for mapping items back to your own dataset without needing to store the item\'s generated id from ingenia.'
#     p.type = :string
#     p.example = '785uU423aC'
#   end

#   item.parameter name: 'tag_ids' do |p|
#     p.description = "The tags you want to have associated with this text item."
#     p.type = :array
#     p.example = '[ "politics", "education", "r&d" ]'
#   end

#   item.parameter name: 'tag_sets' do |p|
#     p.description = "Groups of tags that you consider of the same type; tags will come as belonging of a tag set"
#     p.type = :hash
#     p.example = '{ "category": [ "politics", "education", "r&d" ], "geography": [ "united kingdom" ] }'
#   end

#   item.example = '{"created_at":"2013-12-16T11:24:52+00:00","id":"e19e134d0e79153349ff78a674283e0b","last_classified_at":null,"text":"What type of cheese is the best cheese?","updated_at":"2013-12-16T11:24:56+00:00","tag_sets":[{"Cookery":{"id":107,"tags":["cheese"]}}}]}'
# end

define_api name: 'test' do |api|
  api.description 'Example API'
  api.endpoint = 'http://api.where.you.at.com'
  api.version = '1.0'
  api.format = 'json'
  

  # api.object(json_item)
  

  #
  # Example Resource /items
  #
  # api.resource name: 'items' do |r|
  #   r.description = "Nuggets of textual content: somewhat self-contained and homogeneous."
  #  
  #   r.request name: 'index' do |req|
  #     req.description = 'An index of all your items'
  #     req.call_type = :get
  #     req.path = '/items'
  #
  #     req.parameter api_key
  #     req.parameter limit
  #     req.parameter full_text
  #     req.parameter offset
  #   end
  #
  #   r.request name: 'show' do |req|
  #     req.description = 'View a single item'
  #     req.call_type = :get
  #     req.path = '/items/:id'
  #
  #     req.parameter api_key
  #     req.parameter full_text
  #     req.parameter name: 'id' do |p|
  #       p.description = 'The ID of the item you want to show.'
  #       p.type = :string
  #       p.example = '3casjghd67'
  #       p.required = true
  #     end
  #   end
  #
  #   r.request name: 'create' do |req|
  #     req.description = 'Create a new item'
  #     req.call_type = :post
  #     req.path = '/items'
  #
  #     req.parameter name: 'file' do |p|
  #       p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are; Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx).'
  #       p.type = :multipart
  #     end
  #
  #     req.parameter name: 'update_existing' do |p|
  #       p.description = 'If the same text is sent, should the existing item be updated on Ingenia? If true then any tags supplied will overwrite those set on the existing item (default). If false, no data is changed and a response is returned with a 409 code (Conflict) together with the existing item as JSON.'
  #       p.default = true
  #     end
  #
  #     req.parameter name: 'classify' do |p|
  #       p.description = 'Should the response also include a classification.'
  #       p.default = false
  #     end
  #
  #     req.parameter api_key
  #     req.parameter json_item
  #   end
  #
  #   r.request name: 'update' do |req|
  #     req.description = 'Update an existing item'
  #     req.call_type = :put
  #     req.path = '/items/:id'
  #
  #     req.parameter name: 'id' do |p|
  #       p.description = 'The ID of the item you want to update.'
  #       p.type = :string
  #       p.example = '3casjghd67'
  #       p.required = true
  #     end
  #     req.parameter api_key
  #     req.parameter json_item
  #     req.parameter name: 'file' do |p|
  #       p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are; Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx).'
  #       p.type = :multipart
  #     end
  #   end
  #
  #   r.request name: 'delete' do |req|
  #     req.description = 'Delete an existing item'
  #     req.call_type = :delete
  #     req.path = '/items/:id'
  #
  #     req.parameter name: 'id' do |p|
  #       p.description = 'The ID of the item you want to delete.'
  #       p.type = :string
  #       p.example = '3casjghd67'
  #       p.required = true
  #     end
  #     req.parameter api_key
  #   end
  # end
end