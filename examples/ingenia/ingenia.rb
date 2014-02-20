$LOAD_PATH << '.'
require 'bundler/setup'
require 'doc_smoosher'

extend DocSmoosher::TopLevel

# Shared fields
limit = define_parameter( name: 'limit' ) do |p|
  p.description = 'How many results to return'
  p.type = :integer
  p.default = 50
end

offset = define_parameter( name: 'offset' ) do |p|
  p.description = 'Offset returned results by this amount'
  p.type = :integer
  p.default = 0
end

api_key = define_parameter( name: 'api_key' ) do |p|
  p.description = 'Your API key'
  p.type = :string
  p.required = true
  p.example = "hg7JHG6daSgf56FjhgsSa"
end

full_text = define_parameter( name: 'full_text' ) do |p|
  p.description = 'Should the results be shown with all their text'
  p.type = :boolean
  p.default = false
end

# Item JSON POST form
json_item = define_object( name: 'item' ) do |item|
  item.description = "A text item"
  item.parameter name: 'text' do |p|
    p.description = 'Your item\'s content'
    p.type = :string
    p.max = 50_000
  end

  item.parameter name: 'id' do |p|
    p.description = 'Custom text/numeric id. This can be used for mapping items back to your own dataset without needing to store the item\'s generated id from ingenia.'
    p.type = :string
    p.example = '785uU423aC'
  end

  item.parameter name: 'tag_ids' do |p|
    p.description = "The tags you want to have associated with this text item."
    p.type = :array
    p.example = '[ "politics", "education", "r&d" ]'
  end

  item.parameter name: 'tag_sets' do |p|
    p.description = "Groups of tags that you consider of the same type; tags will come as belonging of a tag set"
    p.type = :hash
    p.example = '{ "category": [ "politics", "education", "r&d" ], "geography": [ "united kingdom" ] }'
  end
end

# Tag JSON POST form
json_tag = define_object( name: 'tag' ) do |tag|
  tag.description = "A tag"
  tag.parameter name: 'name' do |p|
    p.description = 'The name of your tag'
    p.type = :string
  end

  tag.parameter name: 'tag_set_id' do |p|
    p.description = 'The ID of the tag_set that this tag belongs to.'
    p.type = :integer
    p.example = '3'
    p.required = true
  end

  tag.parameter name: 'description' do |p|
    p.description = "Textual description of this tag."
    p.type = :string
  end

  tag.parameter name: 'disposition' do |p|
    p.description = "The disposition of the tag. Float value between 0 and 1, defaults to 0.5. Lower values will tend to privilege precision (we suggest 0.25); higher values will tend to privilege recall (we suggest 0.75). For most uses, the default value will work well.

You will want to privilege precision (with a disposition < 0.5) if you want each tag assignment to be accurate, and are less worried about some items being missed, i.e., you prefer to have false negatives than false positives. If the disposition is 0, no item will be tagged with this tag.

You will want to privilege recall (with a disposition > 0.5) if you want each tag assignment to occur, and are less worried about some items being tagged incorrectly, i.e., you prefer to have false positives than false negatives. If the disposition is 1, all items will be tagged with this tag."
    p.type = :float
    p.example = 0.7
    p.default = 0.5
  end
end

# TagSet JSON POST form
json_tag_set = define_object( name: 'tag_set' ) do |tag_set|
  tag_set.description = "A tag set"
  tag_set.parameter name: 'name' do |p|
    p.description = 'The name of your tag set'
    p.type = :string
  end
end


item_json = define_parameter( name: 'json' ) do |p|
  p.description = 'JSON encoded string containing a hash of fields for the text item.'
  p.type = :json
  p.required = false
  p.parameter(json_item)
end


define_api( name: 'Ingenia API' ) do |api|
  api.description = 'Ingenia analyses your textual content and automatically categorises it using your tags.'
  api.endpoint = 'api.ingeniapi.com/v2/'
  api.version = '2.0'
  api.format = 'json'

  ##
  # Items
  #
  api.resource name: 'items' do |r|
    r.description = "Nuggets of textual content: somewhat self-contained and homogeneous."
    
    r.request name: 'index' do |req|
      req.description = 'An index of all your items'
      req.call_type = :get
      req.path = '/items'

      req.parameter api_key
      req.parameter limit
      req.parameter full_text
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'View a single item'
      req.call_type = :get
      req.path = '/items/:id'

      req.parameter api_key
      req.parameter full_text
      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to show.'
        p.type = :string
        p.example = '3casjghd67'
        p.required = true
      end
    end

    r.request name: 'create' do |req|
      req.description = 'Create a new item'
      req.call_type = :post
      req.path = '/items'

      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are; Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx).'
        p.type = :multipart
      end

      req.parameter name: 'update_existing' do |p|
        p.description = 'If the same text is sent, should the existing item be updated on Ingenia? If true then any tags supplied will overwrite those set on the existing item (default). If false, no data is changed and a response is returned with a 409 code (Conflict) together with the existing item as JSON.'
        p.default = true
      end

      req.parameter name: 'classify' do |p|
        p.description = 'Should the response also include a classification.'
        p.default = false
      end

      req.parameter api_key
      req.parameter item_json
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing item'
      req.call_type = :put
      req.path = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to update.'
        p.type = :string
        p.example = '3casjghd67'
        p.required = true
      end
      req.parameter api_key
      req.parameter item_json
      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are; Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx).'
        p.type = :multipart
      end
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing item'
      req.call_type = :delete
      req.path = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to delete.'
        p.type = :string
        p.example = '3casjghd67'
        p.required = true
      end
      req.parameter api_key
    end
  end

  ##
  # Tags
  #
  api.resource name: 'tags' do |r|
    r.description = "Tags are meaningful words or expressions that you want to associate to some or all your content items."
    
    r.request name: 'index' do |req|
      req.description = 'An index of all your tags'
      req.call_type = :get
      req.path = '/tags'

      req.parameter api_key
      req.parameter limit
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'View a single tag'
      req.call_type = :get
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to show.'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      req.parameter api_key
    end

    r.request name: 'create' do |req|
      req.description = 'Create a new tag'
      req.call_type = :post
      req.path = '/tags'

      req.parameter api_key
      req.parameter json_tag
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing tag'
      req.call_type = :put
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to update.'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      req.parameter api_key
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing tag'
      req.call_type = :delete
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to delete.'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      req.parameter api_key
    end
  end

  ##
  # Tag Sets
  #
  api.resource name: 'tag_sets' do |r|
    r.description = "Tag sets are thematically consistent groups of tags, such as, say, world countries, business sectors, product types, companies, concepts, topics, etc."
    
    r.request name: 'index' do |req|
      req.description = 'An index of all your Tag Sets'
      req.call_type = :get
      req.path = '/tag_sets'

      req.parameter api_key
      req.parameter limit
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'View a single Tag Set'
      req.call_type = :get
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the Tag Set you want to show.'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      req.parameter api_key
    end

    r.request name: 'create' do |req|
      req.description = 'Create a new Tag Set'
      req.call_type = :post
      req.path = '/tag_sets'

      req.parameter api_key
      req.parameter json_tag_set
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing Tag Set'
      req.call_type = :put
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the Tag Set you want to update.'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      req.parameter api_key
      req.parameter json_tag_set
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing Tag Set'
      req.call_type = :delete
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the Tag Set you want to delete.'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      req.parameter api_key
    end
  end
end

@api = api

api.to_json