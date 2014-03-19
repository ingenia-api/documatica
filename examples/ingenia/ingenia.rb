
$: << '../../lib'

$LOAD_PATH << '.'
require 'bundler/setup'
require 'doc_smoosher'

extend DocSmoosher::TopLevel

# Shared fields
limit = define_parameter( name: 'limit' ) do |p|
  p.description = 'Return these many results'
  p.type = :integer
  p.default = 50
end

offset = define_parameter( name: 'offset' ) do |p|
  p.description = 'Offset the results I receive by this amount'
  p.type = :integer
  p.default = 0
end

api_key = define_parameter( name: 'api_key' ) do |p|
  p.description = 'Use this API key'
  p.type = :string
  p.required = true
  p.example = "hg7JHG6daSgf56FjhgsSa"
end

full_text = define_parameter( name: 'full_text' ) do |p|
  p.description = 'Show the results with all their text, however long'
  p.type = :boolean
  p.default = '0'
end


# bundle stuff
json_bundle = define_object( name: 'bundle' ) do |bundle|
  bundle.description = "A collection of items related to each other"

  bundle.parameter name: 'name' do |p|
    p.description = 'The name of your bundle'
    p.type = :string
  end
  
  bundle.example = '
  {
    "created_at":"2014-03-13T15:36:51Z",
    "id":47858,
    "name":"Tech Startups",
    "updated_at":"2014-03-13T15:36:51Z"
  }'
end

# Item JSON POST form
json_item = define_object( name: 'item' ) do |item|

  item.parameter name: 'id' do |p|
    p.description = 'A unique text/numeric id. You can use your own, or have Ingenia generate one for you'
    p.default = '[generated]'
    p.type = :string
    p.example = '785uU423aC'
  end

  item.description = "A block of text to which you can associate tags"
  item.parameter name: 'text' do |p|
    p.description = 'Your item\'s content'
    p.type = :string
    p.max = 50_000
  end

  item.parameter name: 'bundle_id' do |p|
    p.description = 'ID of bundle to put item into'
    p.type = :integer
    p.example = '45798'
    p.default = '[user\'s first bundle]'
  end

  item.parameter name: 'tags' do |p|
    p.description = "The name of tags you wish applied to this item. Tags will be looked for first, then created if they do not exist"
    p.type = :array
    p.example = '[ "startups", "saas", "marketing" ]'
  end

  item.parameter name: 'tag_ids' do |p|
    p.description = "The Ingenia IDs of the tags you want to have associated with this item"
    p.type = :array
    p.example = '[ 45, 787, 23 ]'
  end

  item.parameter name: 'tag_sets' do |p|
    p.description = "Groups of tags that you consider of the same type; tags will be returned as belonging to a tag set"
    p.type = :hash
    p.example = '{ "topics": [ "startups", "saas", "marketing" ], "geography": [ "united kingdom" ] }'
  end

  #item.example = '{"created_at":"2013-12-16T11:24:52+00:00","id":"e19e134d0e79153349ff78a674283e0b","last_classified_at":2013-12-16T11:25:07+00:00,"text":"How to get to scale with a saas startup in the UK? etc","updated_at":"2013-12-16T11:24:56+00:00","tag_sets":[{"topics":{"id":156, "tags": [{ "id":4352, "name":"startups"},{"id":7811, "name":"saas"},{"id":1327, "name":"marketing"}]}}, {"geography":{"id":622, "tags": [ {"id":3321, "name":"united kingdom"}]}}]}'
end

# Item JSON get form
json_item_show = define_object( name: 'item' ) do |item|
  item.description = "An item"
  item.parameter name: 'text' do |p|
    p.description = 'Your item\'s textual content'
    p.type = :string
    p.max = 50_000
  end

  item.parameter name: 'created_at' do |p|
    p.description = 'When this item was created'
    p.type = :date_time
    p.example = '2013-12-16T11:24:52+00:00'
  end
  item.parameter name: 'updated_at' do |p|
    p.description = 'When this item was last updated'
    p.type = :date_time
    p.example = '2013-12-16T11:25:52+00:00'
  end
  item.parameter name: 'last_classified_at' do |p|
    p.description = 'When this item was last classified by the system, or null if it hasn\'t been classified yet'
    p.type = :date_time
    p.example = '2013-12-16T11:25:52+00:00'
  end

  item.parameter name: 'id' do |p|
    p.description = 'A unique text/numeric id. You can use your own, or have Ingenia generate one for you'
    p.type = :string
    p.example = '785uU423aC'
  end

  item.example = '
  {
    "created_at":"2013-12-16T11:24:52+00:00",
    "id":"e19e134d0e79153349ff78a674283e0b",
    "last_classified_at":2013-12-16T11:25:07+00:00,
    "text":"How to get to scale with a saas startup in the UK? etc",
    "updated_at":"2013-12-16T11:24:56+00:00",
    "tag_sets":
      [ 
        {  
          "topics":
          {
            "id":156, 
            "tags": 
              [
                { 
                  "id":4352, 
                  "name":"startups"
                },
                { 
                  "id":7811, 
                  "name":"saas"
                },
                { 
                  "id":1327, 
                  "name":"marketing"
                }
              ]
          }
        }, 
        {
          "geography":
          {
            "id":622, 
            "tags": 
              [ 
                {
                  "id":3321, 
                  "name":"united kingdom"
                }
              ]
          }
        }
      ]
  }'
end

# Tag JSON POST form
json_tag = define_object( name: 'tag' ) do |tag|
  tag.description = "A tag"
  tag.parameter name: 'name' do |p|
    p.description = 'The name of your tag'
    p.type = :string
  end

  tag.parameter name: 'tag_set_id' do |p|
    p.description = 'The ID of the tag_set to which this tag belongs'
    p.type = :integer
    p.example = '3787'
    p.required = true
  end

  tag.parameter name: 'description' do |p|
    p.description = "A description of this tag"
    p.type = :string
  end

  tag.parameter name: 'disposition' do |p|
    p.description = "The disposition of the tag. Float value between 0 and 1, defaults to 0.5. Lower values will tend to privilege precision (we suggest 0.25); higher values will tend to privilege recall (we suggest 0.75). For most uses, the default value will work well.

You will want to privilege precision (with a disposition < 0.5) if you want each tag assignment to be accurate, and are less worried about some items being missed, i.e., you prefer to have false negatives than false positives. If the disposition is 0, no item will be tagged with this tag.

You will want to privilege recall (with a disposition > 0.5) if you want each tag assignment to occur, and are less worried about some items being tagged incorrectly, i.e., you prefer to have false positives than false negatives. If the disposition is 1, all items will be tagged with this tag."
    p.type = :float
    p.example = 0.75
    p.default = 0.5
  end

  tag.example = '
  {
    "confidence":0.0,
    "consistency":0.0,
    "created_at":"2014-03-13T12:59:32Z",
    "description":"",
    "id":554273,
    "name":"Text Analytics",
    "tag_set_id":8547,
    "updated_at":"2014-03-13T12:59:32Z"
  }'
end

# TagSet JSON POST form
json_tag_set = define_object( name: 'tag_set' ) do |tag_set|
  tag_set.description = "A tag set"
  tag_set.parameter name: 'name' do |p|
    p.description = 'The name of your tag set'
    p.type = :string
  end

  tag_set.example = '
  {
    "created_at":"2014-03-12T12:17:33Z",
    "id":178751,
    "name":"Big Data",
    "updated_at":"2014-03-12T12:17:33Z"
  }' 
end

define_api( name: 'Ingenia API' ) do |api|

  api.description = 'Ingenia is the next generation of text analytics: it provides categorization, personalization and summarization, and is automatically tailored to your content'
  api.endpoint = 'api.ingeniapi.com/v2/'
  api.version = '2.0'
  api.format = 'json'

  api.object json_bundle 
  api.object json_item 
  api.object json_tag 
  api.object json_tag_set 
  api.object json_item_show 

  ##
  # Items
  #
  api.resource name: 'items' do |r|
    r.description = "Blocks of textual content, typically self-contained and homogeneous"
    
    r.request name: 'index' do |req|
      req.description = 'Returns a list of all your items'
      req.call_type = :get
      req.path = '/items'

      #req.parameter api_key
      req.parameter limit
      req.parameter full_text
      req.parameter offset
    end


    r.request name: 'show' do |req|
      req.description = 'Returns a single item'
      req.call_type = :get
      req.path = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to show'
        p.type = :string
        p.example = '3casjghd67'
        p.required = true
      end
      #req.parameter api_key
      req.parameter full_text
    end

    r.request name: 'create' do |req|
      req.description = 'Creates a new item'
      req.call_type = :post
      req.path = '/items'

      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file types are: Text (txt), Postscript Document Format (pdf), Microsoft Office Documents (doc, docx, xls, xlsx, ppt, pptx)'
        p.type = :multipart
      end

      req.parameter name: 'update_existing' do |p|
        p.description = 'Choice of what to do if the text sent via a create call already exists on Ingenia. If true, the tags supplied will overwrite those on the existing item (default). If false, no data is modified and a response is returned with a 409 code (Conflict) together with the existing item as JSON.'
        p.default = true
      end

      req.parameter name: 'classify' do |p|
        p.description = 'If true, the response will also include a classification.'
        p.default = '0'
      end

      #req.parameter api_key
      req.parameter json_item

      #req.field json_item_show
#      req.field do |f| 
#        f.name = 'id'
#        f.description = 'ID of item' 
#      end
#
#      req.field do |f|
#        f.name = 'text'
#        f.description = 'Text of knowledge item that has been created'
#      end
#
#      req.field do |
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
      #req.parameter api_key
      req.parameter json_item
      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are: Text (txt), Postscript Document Format (pdf), Microsoft Office Documents (doc, docx, xls, xlsx, ppt, pptx)'
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
      #req.parameter api_key
    end
  end

  ##
  # Bundles
  #
  api.resource name: 'bundles' do |r|
    r.description = "Groups of thematically consistent items"
    
    r.request name: 'index' do |req|
      req.description = 'Returns a list of all your bundles'
      req.call_type = :get
      req.path = '/bundles'

      #req.parameter api_key
      req.parameter limit
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'Returns a single bundle'
      req.call_type = :get
      req.path = '/bundles/:id'

      #req.parameter api_key
      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to show'
        p.type = :integer
        p.example = 2314
        p.required = true
      end
    end

    r.request name: 'find_by_name' do |req|
      req.description = 'Looks for a bundle that matches text input'
      req.call_type = :get
      req.path = '/bundles/find_by_name'

      #req.parameter api_key
      req.parameter name: 'text' do |p|
        p.description = 'Text of bundle to look for'
        p.type = :string
        p.example = '"Tech Startups"'
      end
    end

    r.request name: 'create' do |req|
      req.description = 'Creates a new bundle'
      req.call_type = :post
      req.path = '/bundles'
      #req.parameter api_key
      req.parameter json_bundle
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing bundle'
      req.call_type = :put
      req.path = '/bundles/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to update.'
        p.type = :integer
        p.example = 5611
        p.required = true
      end
      #req.parameter api_key
      req.parameter json_bundle
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing bundle'
      req.call_type = :delete
      req.path = '/bundles/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to delete.'
        p.type = :string
        p.example = 'gqj78219nc'
        p.required = true
      end
      #req.parameter api_key
    end
  end

  ##
  # Tags
  #
  api.resource name: 'tags' do |r|
    r.description = "Tags are meaningful words or expressions that you want to associate to some of your items"
    
    r.request name: 'index' do |req|
      req.description = 'List all your tags'
      req.call_type = :get
      req.path = '/tags'

      #req.parameter api_key
      req.parameter limit
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'View a single tag'
      req.call_type = :get
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to show'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      #req.parameter api_key

    end

    r.request name: 'find_by_name' do |req|
      req.description = 'Looks for a tag that matches text input'
      req.call_type = :get
      req.path = '/tags/find_by_name'

      #req.parameter api_key
      req.parameter name: 'text' do |p|
        p.description = 'Text of tag to look for'
        p.type = :string
        p.example = '"Tech Startups"'
      end
    end

    r.request name: 'create' do |req|
      req.description = 'Create a new tag'
      req.call_type = :post
      req.path = '/tags'

      #req.parameter api_key
      req.parameter json_tag
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing tag'
      req.call_type = :put
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to update'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      req.parameter json_tag
      #req.parameter api_key
    end

    r.request name: 'merge' do |req|
      req.description = 'Merge two or more existing tags'
      req.call_type = :put
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag into which you want to merge other tags; the resulting tag will have this name'
        p.type = :integer
        p.example = '42'
        p.required = true
      end

      req.parameter name: 'tag_ids' do |p|
        p.description = 'An array of tag IDs that will be merged into the main tag'
        p.type = :integer
        p.example = '[ 23, 43, 2113 ]'
        p.required = true
      end
      #req.parameter api_key
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing tag'
      req.call_type = :delete
      req.path = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to delete'
        p.type = :integer
        p.example = '42'
        p.required = true
      end
      #req.parameter api_key
    end
  end

  ##
  # Tag Sets
  #
  api.resource name: 'tag_sets' do |r|
    r.description = "Tag sets are thematically consistent groups of tags, such as, say, world countries, business sectors, product types, companies, concepts, topics, etc"
    
    r.request name: 'index' do |req|
      req.description = 'List all your tag sets'
      req.call_type = :get
      req.path = '/tag_sets'

      #req.parameter api_key
      req.parameter limit
      req.parameter offset
    end

    r.request name: 'show' do |req|
      req.description = 'View a single tag set'
      req.call_type = :get
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to show'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      #req.parameter api_key
    end

    r.request name: 'find_by_name' do |req|
      req.description = 'Looks for a tag set that matches text input'
      req.call_type = :get
      req.path = '/tag sets/find_by_name'

      #req.parameter api_key
      req.parameter name: 'text' do |p|
        p.description = 'Text of tag set to look for'
        p.type = :string
        p.example = '"Tech Startups"'
      end
    end

    r.request name: 'create' do |req|
      req.description = 'Create a new tag set'
      req.call_type = :post
      req.path = '/tag_sets'

      #req.parameter api_key
      req.parameter json_tag_set
    end

    r.request name: 'update' do |req|
      req.description = 'Update an existing tag set'
      req.call_type = :put
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to update'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      #req.parameter api_key
      req.parameter json_tag_set
    end

    r.request name: 'merge' do |req|
      req.description = 'Merge two or more existing tag sets'
      req.call_type = :put
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set into which you want to merge the other tag sets; the resulting tag set will have this name'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      
      req.parameter name: 'tag_set_ids' do |p|
        p.description = 'JSON encoded tag set IDs to merge into request tag set'
        p.type = :integer
        p.example = '[ 12, 34, 56 ]'
        p.required = true
      end
      #req.parameter api_key
      #req.parameter json_tag_set
    end

    r.request name: 'delete' do |req|
      req.description = 'Delete an existing tag set'
      req.call_type = :delete
      req.path = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to delete.'
        p.type = :integer
        p.example = '412'
        p.required = true
      end
      #req.parameter api_key
    end
  end
end

@api = api

api.to_json
