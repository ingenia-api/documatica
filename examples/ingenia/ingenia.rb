$: << '../../lib'


$LOAD_PATH << '.'
require 'bundler/setup'
require 'doc_smoosher'

extend DocSmoosher::TopLevel

# Shared fields
limit = define_parameter(name: 'limit') do |p|
  p.description = 'Return these many results'
  p.type        = :integer
  p.default     = 10
end

offset = define_parameter(name: 'offset') do |p|
  p.description = 'Offset the results I receive by this amount'
  p.type        = :integer
  p.default     = 0
end

api_key = define_parameter(name: 'api_key') do |p|
  p.description = 'Use this API key'
  p.type        = :string
  p.required    = true
  p.example     = "hg7JHG6daSgf56FjhgsSa"
end

full_text = define_parameter(name: 'full_text') do |p|
  p.description = 'Show the results with all their text, however long'
  p.type        = :boolean
  p.default     = false
end

uri = define_parameter(name: 'uri') do |p|
  p.description = 'The url of the article you want to extract'
  p.type        = :string
  p.default     = false
end

url = define_parameter(name: 'url') do |p|
  p.description = 'The url of the html you want to return'
  p.type        = :string
  p.default     = false
end

metadata    = define_parameter(name: 'metadata') do |m|
  m.description = <<-DESC
  A list of attributes you can associate to the knowledge item.

  Valid types of metadata are date, string, collection and number.</br>
  'date': which includes a time for when an event occurred</br>
  'string': General purpose content</br>
  'collection': One item from defined collection</br>
  'number': A numerical value

  DESC

  m.type    = :array
  m.example = "[{ name: 'published_date', type: 'date', content: '2012-01-20 00:00:00' }, { name: 'title', type: 'string', content: 'A day to remember',  { name: 'author', type: 'collection', content: 'Joe Bloggs' },      { name: 'author', type: 'collection', content: 'John Smith' }]"
end


##
# Introduction
#

DESCRIPTION =<<-DESC
  <p>Check out the <a href="/vox"> demo </a> to see Ingenia in action.</p>

  <p>Look at the <a href="/faq">FAQ</a> for any questions.</p>

  <p> Go through the documentation and choose if you want to use Ingenia by the API or with the Ruby gem. </p>

  <p> <a href="/contact"> Contact us </a> to get your API key or if you have any questions.</p>

  <p>If you would like to verify your API key or code data path then use the <a href="#call-administrative-calls-status">status</a> call.</p>

  <h3 id='api-libraries'>Ruby API library</h3>
  <a href="https://github.com/ingenia-api/ingenia_ruby">https://github.com/ingenia-api/ingenia_ruby</a>

  <h3 id='api-rate-limiting'>Rate limiting</h3>

  <p>Ingenia by default limits a user to 4 calls per second, for every type of API call. Contact us to have this limit increased or removed if needed. </p>
DESC

json_similarity_response = define_object(name: 'Similarity response') do |sr|

  sr.description = "An array of items that are related to an origin item sent via a similarity API call"

  sr.parameter name: 'id' do |p|
    p.description = 'The ID of the origin item'
    p.type        = :string
  end

  sr.parameter name: 'text' do |p|
    p.description = 'First 50 characters of the text of each related item'
    p.type        = :string
  end

  sr.parameter name: 'mode' do |p|
    p.description = 'If \'tag\', it will determine related items on the basis of their tags; if \'word\', it will do so on the basis of the words contained in the item'
    p.type        = :string
    p.default     = 'tag'
  end

  sr.parameter name: 'similarity' do |p|
    p.description = 'From 0 to 1, it measures how similar each related item is to the origin item; the response will sort items on descending similarity'
    p.type        = :float
  end

  sr.example = '
  {
    [
      { "item": { "id":12182, "text": "The fall in the rand has given wealthy Russians a new location to search for luxury..." }, "mode": "tag", "similarity": 0.62 },
      { "item": { "id":9293, "text": "Robots tend to do jobs that no one wants to do. I am old enough to remember..."  }, "mode": "tag", "similarity": 0.55 },
      { "item": { "id":25333, "text": "The market for RMB credit raised outside China has gone four weeks without a..." }, "mode": "word", "similariy": 0.22 }
    ]
  }'
end

# bundle
json_bundle              = define_object(name: 'Bundle: create / update input') do |bundle|
  bundle.description = "A collection of items related to each other"
  bundle.type        = :json
  bundle.required    = true
  bundle.parameter name: 'name' do |p|
    p.description = 'The name of your bundle'
    p.type        = :string
  end

  bundle.this_is_json!

  bundle.parameter name: 'tag_set_ids' do |p|
    p.description =<<-DESC
    An array of tag set IDs to be applied to this bundle. The tags in these tag sets will be available to the items in the bundle.
    If an existing bundle already has tag sets, then these can be removed by omitting the ID in the call.
    DESC
    p.type = :array
  end

  bundle.example = '
  {
    "name":"Tech Startups",
    "tag_sets": [
      {
        "id" : 2820,
        "name" : "Tag Set One"
      },
      {
        "id" : 2819,
        "name" : "Tag Set Two"
      }
    ]
  }'
end

json_bundle_show = define_object(name: 'Bundle: show output') do |bundle|
  bundle.description = "A collection of items related to each other"
  bundle.parameter name: 'id' do |p|
    p.description = 'A unique numeric id generated by Ingenia'
    p.default     = '[generated]'
    p.type        = :numeric
  end

  bundle.parameter name: 'name' do |p|
    p.description = 'The name of your bundle'
    p.type        = :string
  end

  bundle.parameter name: 'tag_sets' do |ts|
    ts.description = 'The tag sets that are currently attached to this bundle. Items within the bundle can use all the tags in these tag sets.'
    ts.type        = :array
  end

  bundle.parameter name: 'created_at' do |p|
    p.description = 'When this bundle was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  #We should probably not show this to the user
  bundle.parameter name: 'updated_at' do |p|
    p.description = 'When this bundle was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  bundle.example = '
  {
    "id":47858,
    "name":"Tech Startups",
    "tag_sets": [
      { "name": "technology", "id": 14562 },
      { "name": "business", "id": 666 }
    ],
    "created_at":"2014-03-13T15:36:51Z",
    "updated_at":"2014-03-13T15:36:51Z",
  }'
end

json_basic_response = define_object(name: 'Basic response format') do |brf|

  brf.description = "All responses from the API gateway have the following format"

  brf.parameter name: 'version' do |p|
    p.description = 'The version of the API that is responding'
    p.type        = :string
    p.example     = '"2.0"'
  end

  #data
  brf.parameter name: 'data' do |p|
    p.description = 'The data payload response from the call'
    p.type        = :object
  end


  #status
  brf.parameter name: 'status' do |p|
    p.description = '"okay" if the call is processed correctly, otherwise it will be "error"'
    p.type        = :string
  end

  #message
  brf.parameter name: 'message' do |p|
    p.description = 'A message describing the nature of the error, returned if an error occurred'
    p.type        = :string
  end

end

# Item JSON POST form
json_item           = define_object(name: 'Item: create / update input') do |item|
  item.description = "An item is a block of text to which you can associate tags, that belongs to a bundle"
  item.type        = :json
  item.required    = true

  item.this_is_json!

  item.parameter name: 'id' do |p|
    p.description = 'An alphanumeric id unique to each bundle. You can use your own, or have Ingenia generate one for you'
    p.default     = '[generated]'
    p.type        = :string
    p.example     = '785uU423aC'
  end

  item.parameter name: 'text' do |p|
    p.description = 'Your item\'s content. [1]'
    p.type        = :string
  end

  item.parameter name: 'url' do |p|
    p.description = 'Source URL to get text from. Ingenia will extract the most relevant text [1]'
    p.type        = :string
    p.example     = 'https://www.example.com'
  end

  item.parameter name: 'bundle_id' do |p|
    p.description = 'ID of the bundle in which to put the item'
    p.type        = :integer
    p.default     = '[user\'s first bundle]'
  end

  item.parameter name: 'tag_sets' do |p|
    p.description = "A hash of tag sets, each of which is an array of tags that you consider of the same type [2]"
    p.type        = :hash
    p.example     = '{ "topics": [ "startups", "saas", "marketing" ], "geography": [ "United Kingdom", "Italy" ] }'
  end

  item.parameter name: 'tags' do |p|
    p.description = "An array with the name of the tags you wish to assign to this item. If the tag doesn\'t exist, it will be created [2]."
    p.type        = :array
    p.example     = <<-EOF
[ "startups", "saas", "marketing" ]'
    EOF
  end

  item.parameter name: 'tags' do |p|
    p.description = "As above, but with a user-assigned score. The score should be a number between 0 and 1 that quantifies the strength of the association between the item and the tag (1: highest) [2]."
    p.type        = :hash
    p.example     = <<-EOF
{ "startups" : 0.2 , "sass" : 0.7, "marketing" : 1 }
    EOF
  end

  item.parameter name: 'tag_ids' do |p|
    p.description = "The Ingenia IDs of the tags you wish to assign to this item [2]"
    p.type        = :array
    p.example     = '[ 45, 787, 23 ]'
  end

  item.parameter name: 'language' do |p|
    p.description = "The ISO639-2 code for language (see the full list at http://www.loc.gov/standards/iso639-2/php/English_list.php), in lower case.
    This enables you to ensure Ingenia processes this content in that language.
    If not passed, Ingenia assumes the language is the same as the bundle to which the item belongs.
    If 'auto', Ingenia will automatically detect the language: especially useful for multi-language bundles."
    p.type        = :string
    p.example     =  "'en'"
  end

  item.parameter metadata

  item.parameter name: 'delimiters' do |p|
    p.description = <<-DESC
    <p>A list of characters or words that Ingenia will use to split the text you send into smaller blocks. This is useful if you want to identify and analyse tags at a per-sentence level.</p>
    <p>For instance, you may break down the text: <i style='font-style:italic'>'The staff were friendly, but the food was disappointing'</i> into two by splitting on the word <i style='font-style:italic'>' but '</i>: </p>
    <p>i.e. The first part of the text could be categorised as 'staff' and 'positive' and the second part as 'room' and 'negative', thus enabling you to identify granularly which specific features are or are not appreciated.</p>

    <p>You can send an empty array in order to use the default set of delimiters to split the text:</p>
    <p><i style='font-style:italic'>['. ', '? ', '! ', '\n']</i>.</p>

    <p>Please note, you will need to specify for each delimiters whether to require a subsequent space. i.e. <i style='font-style:italic'>[':']</i> is not the same as <i style='font-style:italic'>[': ']</i>. This also applies to using words. i.e. splitting on <i style='font-style:italic'>['but']</i> is not the same as <i style='font-style:italic'>[' but ']</i>.</p>
    <br>
    DESC

    p.type       = :array
    p.example    = <<-EXAMPLE
    ['. ', ' but ']
    <p>This would split the following text:</p>
    <i style='font-style:italic'>"I liked it overall. The food was good but the service could be improved."</i>
    <p>into three separate chunks:</p>

    "I liked it overall"
<br>
    "The food was good"
<br>
    "the service could be improved."
    EXAMPLE
  end

  item.footnote =<<-FN
    <p>[1] You can input content as one of these fields: text, a URL, a file. Formats
    supported for files include txt, html, pdf and all MS Office formats. If you send a file, it will extract the text
    from it.</p>
    <p>The text and the URL are input as part of the JSON component. The file
    is sent as a multipart encoded https field.</p>

    <p>[2] Only specify one of the following: tag_sets, tags or tag_ids </p>
  FN

  item.example = <<-EXAMPLE
  {
    text: "High tech startups and their positive power to change for good",
    tag_sets: {
      "Topics": [ "startups", "technology" ],
      "Mood": [ "positive" ]
    }
  }
  EXAMPLE

end

# Item JSON get form
json_item_show      = define_object(name: 'Item: show output') do |item|

  item.parameter name: 'bundle_id' do |p|
    p.description = 'The id of the bundle that this item belongs to'
    p.type        = :numeric
  end

  item.parameter name: 'bundle_name' do |p|
    p.description = 'The name of the bundle that this item belongs to'
    p.type        = :string
  end

  item.parameter name: 'concordance' do |p|
    p.description = 'The extent to which the user and Ingenia agree on the categorisation of the item. 0 if the tags are different, 1 if they are identical. Use this to identify content that may need to be reviewed'
    p.type        = :float
  end

  item.parameter name: 'id' do |p|
    p.description = 'A unique alphanumeric id'
    p.type        = :string
    p.example     = '785uU423aC'
  end

  item.parameter name: 'item_state' do |p|
    p.description = 'The current state of the item'
    p.type        = :string
  end

  item.parameter name: 'language' do |p|
    p.description = 'The language of the content in this item'
    p.type        = :string
  end

  item.parameter name: 'text' do |p|
    p.description = 'Your item\'s content'
    p.type        = :string
  end

  item.parameter name: 'created_at' do |p|
    p.description = 'When this item was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  #We should probably not show this to the user
  item.parameter name: 'updated_at' do |p|
    p.description = 'When this item was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  item.parameter name: 'last_classified_at' do |p|
    p.description = 'When this item was last classified by the system; null if it hasn\'t been classified yet'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  item.parameter name: 'tag_sets' do |p|
    p.description = 'An array of tag sets associated to the item'
    p.type        = :array
  end

  item.parameter name: 'tag_set' do |p|
    p.description = 'A hash containing the tag set id and the array of tags associated to the item'
    p.type        = :hash
  end

  item.parameter name: 'tag' do |p|
    p.description = 'A hash with the details of a tag associated to the item, including its id, name, user assigned score and user_selected'
    p.type        = :hash
  end

  item.parameter name: 'score' do |p|
    p.description = 'An aggregation of the machine and rule scores, between 0 (lowest) and 1 (highest).'
    p.type        = :numeric
  end

  item.parameter name: 'user_selected' do |p|
    p.description = 'Deprecated: please use user_assigned value, this will be removed in the next release'
    p.type        = :string
  end

  item.parameter name: 'user_assigned' do |p|
    p.description = 'true if the tag was assigned to the item by the user, false if it was assigned by Ingenia'
    p.type        = :boolean
  end

  item.parameter name: 'user_assigned_score' do |p|
    p.description = 'score assigned by the user when tag was created'
    p.type        = :float
  end

  item.parameter name: 'machine_score' do |p|
    p.description = 'A number which quantifies the strength of the association between an item and a tag, between 0 (lowest) and 1 (highest)'
    p.type        = :numeric
  end

  item.parameter name: 'rule_score' do |p|
    p.description = 'A number which quantifies the strength of the association between an item and a tag score, between -1 (lowest) and 1 (highest)'
    p.type        = :numeric
  end

  item.parameter name: 'membership_degree' do |p|
    p.description = 'the degree to which this item is a member of its bundle'
    p.type        = :float
  end

  item.parameter name: 'metadata' do |p|
    p.description = 'any additional data you associated to this content; it may include dates, values, urls, additional text, etc.'
    p.type        = :array
  end

  item.parameter name: 'aggregated_items' do |p|
    p.description = 'This only appears for items that have been split using delimiters defined during item creation. It is a list of the component items that make up the overall text.'
    p.type        = :array
  end

  item.parameter name: 'partial_id' do |p|
    p.description = 'If there are aggregated_items present, each will have a partial_id to uniquely identify it. This will be an alphanumeric string containing the overall item id, a number representing its position in the original text, and a unique identifier'
    p.type        = :string
    p.example     = "6bbd66632349f38b87af3cb8b370a481_00001_e64305ac4dfe6168e52f1afb32e713d5\n   ------>   overallitemid_positionintext_uniqueidentifier"
  end

  item.example = '
  {
    "id":"e19e134d0e79153349ff78a674283e0b",
    "last_classified_at":2013-12-16T11:25:07+00:00,
    "text":"How to get to scale with a saas startup in the UK? ...",
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
                  "name":"startups",
                  "user_selected": "f",
                  "user_assigned": false,
                  "score":"0.8",
                  "machine_score":"0.45",
                  "rule_score": "0.35",
                  "user_assigned_score": null
                },
                {
                  "id": 7811,
                  "name": "saas",
                  "user_selected": "t",
                  "user_assigned": true,
                  "score": "0.45",
                  "machine_score":"0.45",
                  "rule_score": null,
                  "user_assigned_score": 0.7
                },
                {
                  "id":1327,
                  "name":"marketing",
                  "user_selected": "t",
                  "user_assigned": true,
                  "score": "0.50",
                  "machine_score":"0.45",
                  "rule_score": "0.05",
                  "user_assigned_score": 0.7
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
                  "name":"united kingdom",
                  "score":"0.37",
                  "user_selected": "t",
                  "user_assigned": true
                }
              ]
          }
        }
      ]
    "created_at":"2013-12-16T11:24:52+00:00",
    "updated_at":"2013-12-16T11:24:56+00:00"
  }'
end

# Tag JSON POST form
json_tag            = define_object(name: 'Tag: create / update input') do |tag|
  tag.description = "Something you want to associate to an item, e.g., a concept, topic, tone, sentiment, keyword, person, company, product, etc."
  tag.type        = :json
  tag.this_is_json!
  tag.required = true

  tag.parameter name: 'name' do |p|
    p.description = 'The name of your tag; we advise to make it short but meaningful; unique to each tag set'
    p.type        = :string
    p.required    = true
  end

  tag.parameter name: 'tag_set_id' do |p|
    p.description = 'The ID of the tag_set to which this tag belongs'
    p.type        = :integer
    p.required    = true
  end

  tag.parameter name: 'description' do |p|
    p.description = "A description of this tag: this is helpful to define in a focused way how the tag should be used"
    p.type        = :string
  end

  tag.parameter name: 'disposition' do |p|
    p.description = "The disposition of the tag. Float value between 0 and 1, defaults to 0.5. Lower values will tend to privilege precision (we suggest 0.25); higher values will tend to privilege recall (we suggest 0.75). For most uses, the default value will work well.

You will want to privilege precision (with a disposition < 0.5) if you want each tag assignment to be accurate, and are less worried about some items being missed, i.e., you prefer to have false negatives than false positives. If the disposition is 0, no item will be tagged with this tag.

You will want to privilege recall (with a disposition > 0.5) if you want each tag assignment to occur, and are less worried about some items being tagged incorrectly, i.e., you prefer to have false positives than false negatives. If the disposition is 1, all items will be tagged with this tag."
    p.type        = :float
    p.default     = 0.5
  end

  tag.example = '
  {
    "name":"Text Analytics",
    "tag_set_id":37874,
    "description":"A set of techniques designed to extract valuable information from textual content",
    "disposition": 0.5
  }'
end

json_tag_show = define_object(name: 'Tag: show output') do |tag|
  tag.description = "Something you want to associate to an item, e.g., a concept, topic, tone, sentiment, keyword, person, company, product, etc."

  tag.parameter name: 'id' do |p|
    p.description = 'A unique numeric id, generated by Ingenia'
    p.type        = :numeric
  end

  tag.parameter name: 'name' do |p|
    p.description = 'The name of your tag'
    p.type        = :string
  end

  tag.parameter name: 'tag_set_id' do |p|
    p.description = 'The ID of the tag_set to which this tag belongs'
    p.type        = :integer
  end

  tag.parameter name: 'confidence' do |p|
    p.description = "From 0 to 1; confidence gets closer to 1 the more Ingenia considers the training for this tag sufficient; if this value is low, we advise to increase your training set for this tag"
    p.type        = :float
  end

  tag.parameter name: 'description' do |p|
    p.description = "A description of this tag"
    p.type        = :string
  end

  tag.parameter name: 'created_at' do |p|
    p.description = 'When this tag was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  #We should probably not show this to the user
  tag.parameter name: 'updated_at' do |p|
    p.description = 'When this tag was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  tag.example = '
  {
    "id":554273,
    "name":"Text Analytics",
    "tag_set_id":8547,
    "confidence":0.95,
    "description":"the process of deriving high-quality information from text",
    "created_at":"2014-03-13T12:59:32Z",
    "updated_at":"2014-03-13T12:59:32Z"
  }'
end

json_tag_rules_show = define_object(name: 'Tag rules: index output') do |tag_rule|
  tag_rule.description = "A list of rules applied to a tag to influence whether or not to apply the tag to an item."

  tag_rule.parameter name: 'tag_id' do |p|
    p.description = 'The ID of the tag to which this tag rule belongs'
    p.type        = :integer
    p.required    = true
  end

  tag_rule.parameter name: 'text' do |p|
    p.description = 'the word or phrase that influences the "target tag"'
    p.type        = :string
  end

  tag_rule.parameter name: 'language' do |p|
    p.description = 'the language for "text" (optional, required if you pass the "text" parameter'
    p.type        = :string
  end

  tag_rule.parameter name: 'rule_tag_id' do |p|
    p.description = 'the id of the "rule tag", or the tag that influences the "target tag"'
    p.type        = :integer
  end

  tag_rule.parameter name: 'influence' do |p|
    p.description = 'the extent to which the "target tag" is influenced by either "text" or "rule tag", a number between -1 (greatest effect to prevent "target tag" from being applied) to 1 (greatest effect to ensure "target tag" is applied).'
    p.type        = :float
  end

  tag_rule.parameter name: 'tag_rule_mode' do |p|
    p.description =  <<-DESC
  A the way in which the rule is being applied. These modes are supported:</br>
  'word_present': apply "influence" to the "target tag" if the "text" is present</br>
  'word_absent':  apply "influence" to the "target tag" if the "text" is absent</br>
  'word_skip':  ignore this "text", if it is present ("influence" is not used in this mode)</br>
  'word_cap': cap the role of "text" for the "target tag" to at most the value of "influence"</br>
  'tag_present': apply "influence" to the "target tag" if the "rule_tag" is present (Note: this is useful to create hierarchies: "target_tag" is a parent, "rule_tag" is a child, "influence" is 1)

  DESC
    p.type        = :string
  end

  tag_rule.parameter name: 'created_at' do |p|
    p.description = 'When this tag rule was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  tag_rule.parameter name: 'updated_at' do |p|
    p.description = 'When this tag rule was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  tag_rule.example = '
  {
    "tag": {
      "id":554273,
      "name":"Text Analytics",
    },
    "tag_rule": [{
      "text": "data",
      "influence": 0.4,
      "language": "en",
      "tag_rule_mode":"word_present",
      "created_at":"2014-03-13T12:59:32Z",
      "updated_at":"2014-03-13T12:59:32Z"
    },
    ...
    ]
  }'
end

json_tag_rule_show = define_object(name: 'Tag Rule: show output') do |tag_rule|
  tag_rule.description = "A rule applied to a tag to influence whether or not to apply the tag to an item."

  tag_rule.parameter name: 'tag_id' do |p|
    p.description = 'The ID of the tag to which this tag rule belongs'
    p.type        = :integer
    p.required    = true
  end

  tag_rule.parameter name: 'text' do |p|
    p.description = 'the word or phrase that influences the "target tag"'
    p.type        = :string
  end

  tag_rule.parameter name: 'language' do |p|
    p.description = 'the language for "text" (optional, required if you pass the "text" parameter'
    p.type        = :string
  end

  tag_rule.parameter name: 'rule_tag_id' do |p|
    p.description = 'the id of the "rule tag", or the tag that influences the "target tag"'
    p.type        = :integer
  end

  tag_rule.parameter name: 'influence' do |p|
    p.description = 'the extent to which the "target tag" is influenced by either "text" or "rule tag", a number between -1 (greatest effect to prevent "target tag" from being applied) to 1 (greatest effect to ensure "target tag" is applied).'
    p.type        = :float
  end

  tag_rule.parameter name: 'tag_rule_mode' do |p|
    p.description =  <<-DESC
  A the way in which the rule is being applied. These modes are supported:</br>
  'word_present': apply "influence" to the "target tag" if the "text" is present</br>
  'word_absent':  apply "influence" to the "target tag" if the "text" is absent</br>
  'word_skip':  ignore this "text", if it is present ("influence" is not used in this mode)</br>
  'word_cap': cap the role of "text" for the "target tag" to at most the value of "influence"</br>
  'tag_present': apply "influence" to the "target tag" if the "rule_tag" is present (Note: this is useful to create hierarchies: "target_tag" is a parent, "rule_tag" is a child, "influence" is 1)

  DESC
    p.type        = :string
  end

  tag_rule.parameter name: 'created_at' do |p|
    p.description = 'When this tag rule was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  tag_rule.parameter name: 'updated_at' do |p|
    p.description = 'When this tag rule was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  tag_rule.example = '
  {
    "tag": {
      "id":554273,
      "name":"Text Analytics",
    },
    "tag_rule": {
      "text": "data",
      "influence": 0.4,
      "language": "en",
      "tag_rule_mode":"word_present",
      "created_at":"2014-03-13T12:59:32Z",
      "updated_at":"2014-03-13T12:59:32Z"
    }
  }'
end

# TagRule JSON POST form
json_tag_rule_create = define_object(name: 'Tag rule: create input') do |tag_rule|
  tag_rule.description = "A rule to apply to a tag to influence use of that tag."
  tag_rule.type        = :json
  tag_rule.this_is_json!

  tag_rule.parameter name: 'tag_id' do |p|
    p.description = 'The ID of the tag to which this tag rule belongs'
    p.type        = :integer
    p.required    = true
  end

  tag_rule.parameter name: 'text' do |p|
    p.description = 'the word or phrase that influences the "target tag"'
    p.type        = :string
  end

  tag_rule.parameter name: 'language' do |p|
    p.description = 'the language for "text" (optional, required if you pass the "text" parameter'
    p.type        = :string
  end

  tag_rule.parameter name: 'rule_tag_id' do |p|
    p.description = 'the id of the "rule tag", or the tag that influences the "target tag"'
    p.type        = :integer
  end

  tag_rule.parameter name: 'influence' do |p|
    p.description = 'the extent to which the "target tag" is influenced by either "text" or "rule tag", a number between -1 (greatest effect to prevent "target tag" from being applied) to 1 (greatest effect to ensure "target tag" is applied).'
    p.type        = :float
  end

  tag_rule.parameter name: 'tag_rule_mode' do |p|
    p.description =  <<-DESC
  A the way in which the rule is being applied. These modes are supported:</br>
  'word_present': apply "influence" to the "target tag" if the "text" is present</br>
  'word_absent':  apply "influence" to the "target tag" if the "text" is absent</br>
  'word_skip':  ignore this "text", if it is present ("influence" is not used in this mode)</br>
  'word_cap': cap the role of "text" for the "target tag" to at most the value of "influence"</br>
  'tag_present': apply "influence" to the "target tag" if the "rule_tag" is present (Note: this is useful to create hierarchies: "target_tag" is a parent, "rule_tag" is a child, "influence" is 1)

    DESC
    p.type        = :string
  end

  tag_rule.example = '
  {
    "text":"ruby",
    "influence":0.5,
    "language":"en",
    "tag_rule_mode":"word_present"
  }

  OR

  {
    "influence":0.5,
    "rule_tag_id":12,
    "tag_rule_mode":"tag_present"
  }'

  tag_rule.footnote = <<-FN
      <p>[1] A tag rule must include either an entry for the tuple "text" and "language", or for "rule tag", but NOT both. </p>
      <p>[2] You can associate as many rules as you like to a tag. Do so cautiously, and make sure they work well together, or you risk to apply the target tag all the time, or never.</p>
  FN
end

# TagSet JSON POST form
json_tag_set         = define_object(name: 'Tag set: create / update input') do |tag_set|
  tag_set.description = "A collection of thematically consistent tags"
  tag_set.type        = :json
  tag_set.required    = true
  tag_set.this_is_json!

  tag_set.parameter name: 'name' do |p|
    p.description = 'The name of your tag set; we advise to make it short but meaningful; must be unique'
    p.type        = :string
  end

  tag_set.parameter name: 'bundle_ids' do |p|
    p.description = 'A list of the ids of bundles to which the tag set should be associated. Can be left blank if tag set should not be associated to any just yet.'
    p.type        = :array
  end

  tag_set.example = '
  {
    "name" : "Big Data"
    "bundle_ids" : "[42, 56]"
  }'
end

json_tag_set_show = define_object(name: 'Tag set: show output') do |tag_set|
  tag_set.description = "A collection of thematically consistent tags"

  tag_set.parameter name: 'id' do |p|
    p.description = 'A unique numeric id, generated by Ingenia'
    p.type        = :numeric
  end

  tag_set.parameter name: 'name' do |p|
    p.description = 'The name of your tag set'
    p.type        = :string
  end

  tag_set.parameter name: 'created_at' do |p|
    p.description = 'When this tag set was created'
    p.type        = :date_time
    p.example     = '2013-12-16T11:24:52+00:00'
  end

  #We should probably not show this to the user
  tag_set.parameter name: 'updated_at' do |p|
    p.description = 'When this tag set was last updated'
    p.type        = :date_time
    p.example     = '2013-12-16T11:25:52+00:00'
  end

  tag_set.parameter name: 'bundles' do |p|
    p.description = 'A list of bundles associated to this tag set'
    p.type        = :array
  end

  tag_set.example = '
  {
    "id":178751,
    "name":"Big Data",
    "created_at":"2014-03-12T12:17:33Z",
    "updated_at":"2014-03-12T12:17:33Z",
    "bundles": [
      {
        "id": 778,
        "name": "A Bundle Name"
      }
    ]
  }'
end

# Classifications
json_classify     = define_object(name: 'Classifications') do |classify|

  classify.example = '
{
  "api_version": "2.0",
  "status": "okay",

  "data": {
    "classification_status": "complete",
    "results": {

      "Software": {
        "id": 6,
        "tags": [
          {
            "id": 31,
            "name": "php",
            "score": 0.655
          },
          {
            "id": 90,
            "name": "php-session",
            "score": 0.315
          },
          {
            "id": 158,
            "name": "pass-by-reference",
            "score": 0.262
          },
          {
            "id": 160,
            "name": "debugging",
            "score": 0.24
          },
          {
            "id": 159,
            "name": "pass-by-value",
            "score": 0.198
          },
          {
            "id": 63,
            "name": "apache",
            "score": 0.132
          }
        ]
      }
    }
  }
}
'

end


define_api(name: 'Ingenia API', description: DESCRIPTION) do |api|

  api.endpoint = 'api.ingeniapi.com/v2/'
  api.version  = '2.0'
  api.format   = 'json'

  api.object json_basic_response
  api.object json_item
  api.object json_item_show
  api.object json_bundle
  api.object json_bundle_show
  api.object json_tag
  api.object json_tag_show
  api.object json_tag_rules_show
  api.object json_tag_rule_show
  api.object json_tag_rule_create
  api.object json_tag_set
  api.object json_tag_set_show
  api.object json_similarity_response


  api.resource name: 'Classifications' do |r|
    r.description = ""

    r.request name: 'Classify' do |req|
      req.description = ''
      req.call_type   = :post
      req.path        = '/classify'

      req.parameter name: 'text' do |p|
        p.description = 'The text you want Ingenia to classify [1]'
        p.type        = :string
        p.example     = 'A comparative study of European secondary education systems illustrated issues related to their budgetary sustainability...'
      end

      req.parameter name: 'url' do |p|
        p.description = 'The source URL from which to extract the text to be classified; Ingenia will extract the most relevant text [1]'
        p.type        = :string
        p.example     = 'https://www.example.com'
      end

      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are: Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx). [1]'
        p.type        = :multipart
        p.example     = 'document.pdf'
      end

      req.parameter name: 'bundle_id' do |p|
        p.description = 'ID of the bundle to which the item belongs'
        p.type        = :integer
        p.default     = '[user\'s first bundle]'
      end

      req.parameter name: 'min_tags' do |p|
        p.description = 'Return at least these many tags'
        p.type        = :integer
        p.default     = 0
      end

      req.parameter name: 'max_tags' do |p|
        p.description = 'Return at most these many tags'
        p.type        = :integer
        p.default     = 6
      end

      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/classify?text=A%20comparative%20study%20of%20European%20secondary%20education%20systems%20illustrated%20issues%20related%20to%20their%20budgetary%20sustainability&api_key=$api_key'

Response:

{
  "classification_status": "complete",
  "text": "A comparative study of European secondary education systems illustrated issues related to their budgetary sustainability",
  "results": {
    "Themes": {
      "tags": [
        {
          "machine_score": -0.15,
          "name": "Ed-tech",
          "id": 174857,
          "rule_score": 0.21,
          "score": 0.06
        }
      ],
      "id": "1627"
    }
  }
}
      EOF
      req.footnote = <<-FN
      <p>[1] You can input content as one of these fields: text, a URL, a file. Formats
    supported for files include txt, html, pdf and all MS Office formats. If you send a file, it will extract the text
    from it.</p>
      <p>The text and the URL are input as part of the JSON component. The file
    is sent as a multipart encoded https field.</p>
      FN
    end


  end


  ##
  # Personalisation
  #

  api.resource name: 'Personalisation' do |r|
    r.description = ""

    # r.request name: 'Similar to' do |req|
    #   req.description = ''
    #   req.call_type = :get
    #   req.path = '/items/:id/similar_to'
    #
    #   req.parameter name: 'id' do |p|
    #     p.description = 'ID of item for which we want other similar items'
    #     p.type = :string
    #     p.required = true
    #   end
    #
    #   req.parameter limit
    #
    #   req.parameter full_text
    #
    #   req.parameter name: 'mode' do |p|
    #     p.description = 'Constrain matches to base similarity on just "tag", just "word", or "auto" (first tags, then words)'
    #     p.type = :string
    #     p.example = 'mode=tag'
    #     p.default = 'auto'
    #   end
    #
    #   req.parameter name: 'metadata_filters' do |p|
    #     p.description = 'Instruct ingenia to only consider knowledge items which match these criteria'
    #     p.type = :string
    #     p.example = 'metadata_filters[author]=Joe%20Bloggs'
    #   end
    #
    #   req.parameter name: 'item_filters' do |p|
    #     p.description = 'Instruct ingenia to only consider knowledge items which were created within specific dates. Dates are inclusive.'
    #     p.type = :string
    #     p.example = 'item_filters[from]=2014-12-25&item_filters[to]=2014-12-30'
    #   end
    #
    #   req.response = json_similarity_response
    # end

    r.request name: 'Similar to' do |req|
      req.description = ''
      req.call_type   = :get
      req.path        = '/items/:id/similar_to'

      req.parameter name: 'id' do |p|
        p.description = 'ID of item to get similar items to'
        p.type        = :string
        p.required    = true
      end

      req.parameter name: 'bundle_id' do |p|
        p.description = 'Tell ingenia which bundle this item is in. If this parameter is omitted, ingenia will only look for the item in the default bundle'
        p.type        = :integer
        p.example     = '77'
      end

      req.parameter name: 'bundle_ids' do |p|
        p.description = 'Restrict your search to one or more bundles. If this parameter is omitted, all bundles will be scanned'
        p.type        = :array
        p.example     = '1,4,77'
      end

      req.parameter name: 'limit' do |p|
        p.description = 'The number of items to return, the maximum is 100.'
        p.type = :integer
        p.example = '15'
      end


      req.parameter full_text

      req.parameter name: 'mode' do |p|
        p.description = 'Constrain matches to base similarity on just "tag", just "word", or "auto" (first tags, then words)'
        p.type        = :string
        p.example     = 'mode=tag'
        p.default     = 'auto'
      end

      req.parameter name: 'metadata_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which match these criteria'
        p.type        = :string
        p.example     = 'metadata_filters[author]=Joe%20Bloggs'
      end

      req.parameter name: 'item_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which were created within specific dates. Dates are inclusive.'
        p.type        = :string
        p.example     = 'item_filters[from]=2014-12-25&item_filters[to]=2014-12-30'
      end

      req.example = <<-EOF
curl -X GET 'https://api.ingeniapi.com/v2/items/ID423455-12-1432321250/similar_to?limit=3&api_key=$api_key'

Response:

[
  {
    "item": {
      "id": "ID1959443-12-1458267383",
      "text": "\n So it’s been a little over a year since GitHub fired me.\nI initially made a vague tweet about leaving the company, and then a few weeks later I wrot..."
    },
    "mode": "word",
    "similarity": 0.194
  },
  {
    "item": {
      "id": "ID1834322-12-1455638255",
      "text": "  \n I worked there. It was literally the worst experience of my career - and I have worked at all of the hardest charging blue chips and two successfu..."
    },
    "mode": "word",
    "similarity": 0.193
  },
  {
    "item": {
      "id": "ID1847748-12-1455841393",
      "text": "Table of Contents (Show)Table of Contents (Hide)\n In This Issue of Venture Weekly:\n Top Story \nWhy Category Leaders Win,  By Ablorde Ashigbi\n Per..."
    },
    "mode": "word",
    "similarity": 0.19
  }
]

      EOF
      req.response = json_similarity_response
    end

    r.request name: 'Similar to text' do |req|
      req.description = ''
      req.call_type   = :post
      req.path        = '/similar_to_text'

      req.parameter name: 'text' do |p|
        p.description = 'Text of item for which we want other similar items'
        p.type        = :string
        p.required    = true
      end

      req.parameter name: 'bundle_id' do |p|
        p.description = 'The bundle this item would most likely be found in. If this parameter is omitted, ingenia assumes the first bundle you created.'
        p.type        = :integer
        p.example     = '77'
      end

      req.parameter name: 'bundle_ids' do |p|
        p.description = 'Find similar items in one or more bundles. If this parameter is omitted, ingenia find items from any of your bundles.'
        p.type        = :array
        p.example     = '1,4,77'
      end

      req.parameter name: 'limit' do |p|
        p.description = 'The number of items to return, the maximum is 100.'
        p.type = :integer
        p.example = '15'
      end

      req.parameter full_text

      req.parameter name: 'mode' do |p|
        p.description = 'Constrain matches to base similarity on just "tag", just "word", or "auto" (first tags, then words)'
        p.type        = :string
        p.example     = 'mode=tag'
        p.default     = 'auto'
      end

      req.parameter name: 'metadata_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which match these criteria'
        p.type        = :string
        p.example     = 'metadata_filters[author]=Joe%20Bloggs'
      end

      req.parameter name: 'item_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which were created within specific dates. Dates are inclusive.'
        p.type        = :string
        p.example     = 'item_filters[from]=2014-12-25&item_filters[to]=2014-12-30'
      end

      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/similar_to_text?text=technology%latest&limit=3&api_key=$api_key'

Response:

[
  {
    "item": {
      "id": "ID218266-10-1425298759",
      "text": "Clarus Financial Technology | Esma\n+447771824036"
    },
    "mode": "word",
    "similarity": 0.966
  },
  {
    "item": {
      "id": "CyberVally",
      "text": "Technology blog group. blogging about latest technology related news."
    },
    "mode": "word",
    "similarity": 0.87
  },
  {
    "item": {
      "id": "TechoTrack",
      "text": "This is a technology blog. We provide latest updates on gadgets and technology."
    },
    "mode": "word",
    "similarity": 0.869
  }
]
      EOF

      req.response = json_similarity_response
    end


    r.request name: 'Similar to tags' do |req|
      req.description = ''
      req.call_type   = :get
      req.path        = '/similar_to_tags'

      req.parameter name: 'tag_ids' do |p|
        p.description = 'JSON encoded array of tag IDs for which we want relevant items'
        p.type        = :array
        p.example     = '[ 45, 787, 23 ]'
        p.required    = true
      end

      req.parameter name: 'bundle_ids' do |p|
        p.description = 'Find similar items in one or more bundles. If this parameter is omitted, ingenia will attempt to infer the bundles from the tags'
        p.type        = :array
        p.example     = '1,4,77'
      end

      req.parameter name: 'limit' do |p|
        p.description = 'The number of items to return, the maximum is 100.'
        p.type = :integer
        p.example = '15'
      end

      req.parameter full_text

      req.parameter name: 'metadata_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which match these criteria'
        p.type        = :string
        p.example     = 'metadata_filters[author]=Joe%20Bloggs'
      end

      req.parameter name: 'item_filters' do |p|
        p.description = 'Instruct ingenia to only consider knowledge items which were created within specific dates. Dates are inclusive.'
        p.type        = :string
        p.example     = 'item_filters[from]=2014-12-25&item_filters[to]=2014-12-30'
      end

      req.example = <<-EOF
curl -X GET 'http://api.ingeniapi.com/v2/similar_to_tags?tag_ids=%5B189454%2C189475%5D&limit=3&api_key=$api_key'

Response:

[
  {
    "item": {
      "id": "ID1959443-12-1458267383",
      "text": "\n So it’s been a little over a year since GitHub fired me.\nI initially made a vague tweet about leaving the company, and then a few weeks later I wrot..."
    },
    "mode": "word",
    "similarity": 0.194
  },
  {
    "item": {
      "id": "ID1834322-12-1455638255",
      "text": "  \n I worked there. It was literally the worst experience of my career - and I have worked at all of the hardest charging blue chips and two successfu..."
    },
    "mode": "word",
    "similarity": 0.193
  },
  {
    "item": {
      "id": "ID1847748-12-1455841393",
      "text": "Table of Contents (Show)Table of Contents (Hide)\n In This Issue of Venture Weekly:\n Top Story \nWhy Category Leaders Win,  By Ablorde Ashigbi\n Per..."
    },
    "mode": "word",
    "similarity": 0.19
  }
]
      EOF
      req.response = json_similarity_response
    end


  end

  ##
  # Summarization
  #
  api.resource name: 'Summarisation' do |r|
    r.description = ""

    r.request name: 'Summarise' do |req|
      req.description = '<code class="get_post">GET</code> is also supported'
      req.call_type   = :post
      req.path        = '/summarise'

      req.parameter name: 'text' do |p|
        p.description = 'Text to summarise: the key sentences will be extracted [1]'
        p.type        = :string
      end

      req.parameter name: 'url' do |p|
        p.description = 'URL of article to summarise: the key sentences will be extracted [1]'
        p.type        = :string
      end

      req.parameter name: 'id' do |p|
        p.description = 'ID of the item to be summarised.'
        p.type        = :string
      end

      req.parameter name: 'include_tags' do |p|
        p.description = 'If true the resulting sentences will be organised by each tag associated to the text, if false they are returned as a list'
        p.type        = :boolean
        p.default     = true
      end

      req.parameter name: 'order_by_position' do |p|
        p.description = 'If true, the results will be ordered as they appear in the text, if false, they will be ordered by the score of the sentence'
        p.type        = :boolean
        p.default     = 'false'
      end

      req.parameter name: 'max_sentences' do |p|
        p.description = 'Maximum number of sentences to return'
        p.type        = :integer
        p.default     = 2
      end

      req.footnote = <<-EOF
      <p>[1] You must input content as either text or a URL. </p>
      EOF

      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/summarise?url=http://techcrunch.com/2016/05/11/charged/&api_key=$api_key'

Response:

{
  "results": {
    "Relevance": {
      "tags": [
        {
          "machine_score": 0.11,
          "name": "Relevance",
          "id": 174842,
          "rule_score": 0.31,
          "score": 0.42,
          "sentences": [
            {
              "text": "Venture capitalists in some sectors are increasingly eager to fund serious scientific innovations, they can be much tougher to do due diligence on than simple software that can be assessed based on immediate market traction.",
              "score": 0.055,
              "position": 4812
            },
            {
              "text": " Otherwise, it could find it difficult to raise additional funding, hire or retain talent, and avoid a negative press spiral.",
              "score": 0.043,
              "position": 4686
            }
          ]
        }
      ],
      "id": "1625"
    }
  }
}
      EOF

    end

  end

  api.resource name: 'Keywords' do |r|
    r.description = ""

    r.request name: 'Show' do |req|
      req.description = 'Returns a list of keywords for a given item'
      req.call_type   = :get
      req.path        = '/keywords/:item_id'

      req.parameter name: 'item_id' do |p|
        p.description = 'ID of the item to show keyfords for.'
        p.type        = :integer
        p.required    = :true
      end

      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/keywords/457?api_key=$api_key'

Response:

[
  {
    "text": "chronograph",
    "occurrences": 1,
    "score": 254
  },
  {
    "text": "measure",
    "occurrences": 3,
    "score": 122
  },
  {
    "text": "time",
    "occurrences": 8,
    "score": 12
  }
]
      EOF

    end

  end

  api.resource name: 'Clusters' do |r|

    r.request name: 'Index' do |req|
      req.description = 'Returns a list of clusters for a given bundle'
      req.call_type   = :get
      req.path        = '/clusters'

      req.parameter name: 'bundle_id' do |p|
        p.description = 'ID of the bundle to show clusters for. If one is not provided, all of your bundles and their respective clusters will be returned.'
        p.type        = :integer
      end

      req.parameter name: 'cluster_limit' do |p|
        p.description = 'Limit on the number of clusters per bundle to return.'
        p.default     = 20
        p.type        = :integer
      end

      req.parameter name: 'word_limit' do |p|
        p.description = 'Limit on the number of words per cluster to return.'
        p.default     = 20
        p.type        = :integer
      end

      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/clusters?word_limit=4&api_key=$api_key'

Response:

[
    {
      "bundle_id": 851,
      "date": "2016-09-23T13:00:16Z",
      "clusters": [
        {
          "cluster": {
            "id": 149061,
            "score": 0.0118,
            "words": [
              {
                "text": "tax",
                "score": 8.5
              },
              {
                "text": "cash",
                "score": 2.57
              },
              {
                "text": "payable",
                "score": 2.5
              },
              {
                "text": "financial",
                "score": 2.2
              }
            ],
            "knowledge_items": [
              4379077,
              4379091,
              4379092,
            ],
            "related_tags": [
              191845
            ],
            "related previous clusters": [
              ...
            ]
          }
        },
        {...}
    }
    {...}
]
      EOF
    end

    r.request name: 'Show' do |req|
      req.description = 'Returns a specific cluster of words'
      req.call_type   = :get
      req.path        = '/clusters/:id'

      req.parameter name: 'id' do |p|
        p.description = 'ID of the cluster you want to show.'
        p.type        = :integer
        p.required    = :true
      end

      req.parameter name: 'word_limit' do |p|
        p.description = 'Limit on the number of words in the cluster to return.'
        p.default     = 20
        p.type        = :integer
      end

      req.example = <<-EOF
      curl 'https://api.ingeniapi.com/v2/clusters/149061?word_limit=4&api_key=$api_key'

      Response:

      {
        "id": 149061,
        "score": 0.0118,
        "words": [
          {
            "text": "tax",
            "score": 8.5
          },
          {
            "text": "cash",
            "score": 2.57
          },
          {
            "text": "payable",
            "score": 2.5
          },
          {
            "text": "financial",
            "score": 2.2
          }
        ],
        "knowledge_items": [
          4379077,
          4379091,
          4379092
        ],
        "related_tags": [
          191845
        ],
        "related previous clusters": []
      }
      EOF

    end

    r.request name: 'Transform cluster into tag' do |req|
      req.description = 'Creates a tag using the given cluster'
      req.call_type   = :put
      req.path        = '/clusters/:id'

      req.parameter name: 'id' do |p|
        p.description = 'ID of the cluster you want to update.'
        p.type        = :integer
        p.required    = :true
      end

      req.parameter name: 'cluster_action' do |p|
        p.description = 'Action for cluster. In this case, it should be "transform_to_tag".'
        p.type        = :string
        p.required    = :true
      end

      req.parameter name: 'tag_set_id' do |p|
        p.description = 'The ID of the Tag Set that you want the new Tag to be saved in.'
        p.type        = :integer
        p.required    = :true
      end

      req.parameter name: 'name' do |p|
        p.description = 'The name for this new tag.'
        p.type        = :string
        p.required    = :true
      end

      req.example = <<-EOF
curl -X PUT -F'json={ "name" : "Cluster Tag", "tag_set_id" : 2860  }' 'https://api.ingeniapi.com/v2/clusters/102165?cluster_action=transform_to_tag&api_key=$api_key'

Response:

{
  "cluster_actions": {
    "action": "transform_to_tag",
    "action_payload": "{\"tag_set_id\"=>\"2860\", \"name\"=>\"Cluster Tag\"}",
    "cluster_id": 102165,
    "created_at": "2016-11-02T12:15:49Z",
    "id": 49,
    "updated_at": "2016-11-02T12:33:52Z"
  },
  "tags": {
    "confidence": 0,
    "created_at": "2016-11-02T12:33:52Z",
    "current_state": "unprocessed",
    "description": "",
    "id": 192038,
    "name": "Cluster Tag",
    "tag_set_id": 2860,
    "updated_at": "2016-11-02T12:33:52Z"
  }
}
      EOF

    end

    r.request name: 'Merge cluster into tag' do |req|
      req.description = 'Merges a given cluster into an existing tag'
      req.call_type   = :put
      req.path        = '/clusters/:id'

      req.parameter name: 'id' do |p|
        p.description = 'ID of the Cluster you want to merge.'
        p.type        = :integer
        p.required    = :true
      end

      req.parameter name: 'cluster_action' do |p|
        p.description = 'Action for cluster. In this case, it should be "merge_into_tag".'
        p.type        = :string
        p.required    = :true
      end

      req.parameter name: 'tag_id' do |p|
        p.description = 'The ID of the Tag you want to merge the Cluster into.'
        p.type        = :integer
        p.required    = :true
      end

      req.example = <<-EOF
curl -X PUT -F'json={ "tag_id" : 192038  }' 'https://api.ingeniapi.com/v2/clusters/102165?cluster_action=merge_into_tag&api_key=$api_key'

Response:

{
  "cluster_actions": {
    "action": "merge_into_tag",
    "action_payload": "{\"tag_id\"=>\"192038\"}",
    "cluster_id": 102165,
    "created_at": "2016-11-02T15:17:49Z",
    "id": 50,
    "updated_at": "2016-11-02T15:35:52Z"
  }
}
      EOF

    end

    r.request name: 'Ignore Cluster' do |req|
      req.description = 'Marks the given cluster to be ignored in future. Use this if it is clearly irrelevant or incorrect.'
      req.call_type   = :put
      req.path        = '/clusters/:id'

      req.parameter name: 'id' do |p|
        p.description = 'ID of the cluster you want to update.'
        p.type        = :integer
        p.required    = :true
      end

      req.parameter name: 'cluster_action' do |p|
        p.description = 'Action for cluster. In this case, it should be "ignore".'
        p.type        = :string
        p.required    = :true
      end

      req.example = <<-EOF
curl -X PUT -F 'https://api.ingeniapi.com/v2/clusters/102165?cluster_action=ignore&api_key=$api_key'

Response:

{
    "cluster_actions": {
      "action": "ignore",
      "action_payload": "",
      "cluster_id": 102165,
      "created_at": "2016-11-17T12:14:16Z",
      "id": 52,
      "updated_at": "2016-11-17T12:14:16Z"
    }
  }
      EOF

    end

  end


  ##
  # Items
  #
  api.resource name: 'Items' do |r|
    r.description = "Blocks of textual content, typically self-contained and homogeneous"

    r.request name: 'Index' do |req|
      req.description = 'Returns a list of all your items'
      req.call_type   = :get
      req.path        = '/items'

      #req.parameter api_key
      req.parameter limit
      req.parameter full_text
      req.parameter offset
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/items?api_key=$api_key'

Response:

[
  {
    "bundle_id": 778,
    "bundle_name": "Here we go again",
    "concordance": null,
    "created_at": "2016-05-10T15:35:59Z",
    "id": "61265a8b2e56ff9693753fd044630ed5",
    "item_state": "processed",
    "language": "en",
    "last_classified_at": "2016-05-10T15:38:47Z",
    "membership_degree": null,
    "updated_at": "2016-05-10T15:38:47Z",
    "tag_sets": [
      {
        "Cooking": {
          "id": 42,
          "tags": [
            {
              "id": 81656,
              "name": "french-cuisine",
              "user_selected": "t",
              "user_assigned": true,
              "score": "0.06",
              "machine_score": "0.06",
              "rule_score": "0",
              "user_assigned_score": "0"
            }
          ]
        }
      }
    ],
    "text": "Some inline text",
    "metadata": [
      null
    ]
  },
  {
    "bundle_id": 778,
    "bundle_name": "Here we go again",
    "concordance": null,
    "created_at": "2016-05-10T16:03:59Z",
    "id": "3fdb62127e7a839e3f4e0ab6de7cd869",
    "item_state": "processed",
    "language": "en",
    "last_classified_at": "2016-05-10T16:04:00Z",
    "membership_degree": null,
    "updated_at": "2016-05-10T16:04:01Z",
    "tag_sets": [
      {
        "Tech": {
          "id": 57,
          "tags": [
            {
              "id": 91567,
              "name": "wearables",
              "user_selected": "t",
              "user_assigned": true,
              "score": "0.06",
              "machine_score": "0.06",
              "rule_score": "0",
              "user_assigned_score": "0"
            }
          ]
        }
      }
    ],
    "text": "Smartwatch cheats force Thai students back to exam halls - BBC News\\nSome 3,000 students in Thailand must retake university entrance exams after a cheating scam involving cameras and smartwatches was uncovered.The sophisticated scam happened at Rangsit University in Bangkok.The ...",
    "metadata": [
      null,
      {
        "name": "url-fetched",
        "type": "date",
        "content": "2016-05-10 16:03:59"
      },
      {
        "name": "url",
        "type": "url",
        "content": "http://www.bbc.co.uk/news/world-asia-36253769"
      }
    ]
  }
]
      EOF

      req.response = json_item_show
    end


    r.request name: 'Show' do |req|
      req.description = 'Returns a single item'
      req.call_type   = :get
      req.path        = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to show'
        p.type        = :string
        p.required    = true
      end
      #req.parameter api_key
      req.parameter full_text
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/items/61265a8b2e56ff9693753fd044630ed5?api_key=$api_key'

Response:

{
  "bundle_id": 778,
  "bundle_name": "Tech Startups",
  "concordance": null,
  "created_at": "2016-05-10T15:35:59Z",
  "id": "61265a8b2e56ff9693753fd044630ed5",
  "item_state": "processed",
  "language": "en",
  "last_classified_at": "2016-05-10T15:38:47Z",
  "membership_degree": null,
  "updated_at": "2016-05-10T15:38:47Z",
  "tag_sets": [
    {
      "Tech": {
        "id": 57,
        "tags": [
          {
            "id": 91567,
            "name": "wearables",
            "user_selected": "t",
            "user_assigned": true,
            "score": "0.06",
            "machine_score": "0.06",
            "rule_score": "0",
            "user_assigned_score": "0"
          }
        ]
      }
    }
  ],
  "text": "Some inline text",
  "metadata": [
    null
  ]
}
      EOF
      req.response = json_item_show
    end

    r.request name: 'Create' do |req|
      req.description = 'Creates a new item'
      req.call_type   = :post
      req.path        = '/items'


      req.parameter json_item

      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file extensions are: Text (txt), Postscript Document Format (pdf) and Microsoft Office Documents (doc, docx, xlsx, ppt, pptx). [1]'
        p.type        = :multipart
      end

      req.parameter name: 'update_existing' do |p|
        p.description = 'Choice of what to do if the item sent via a create call already exists on Ingenia, as determined by its item ID. If this field is true, the tags supplied will overwrite those on the existing item. If false, no data is modified and a response is returned with a 409 code (Conflict) together with the existing item as JSON.'
        p.default     = true
        p.type        = :boolean
      end

      req.parameter name: 'classify' do |p|
        p.description = 'If true, the response will also include a classification'
        p.default     = false
        p.type        = :boolean
      end

      req.footnote =<<-FN
        <p>[1] You can input content as one of these fields: text, a URL, a file. Formats
        supported for files include txt, html, pdf and all MS Office formats. If you send a file, it will extract the text
        from it.</p>
        <p>The text and the URL are input as part of the JSON component. The file
        is sent as a multipart encoded https field.</p>

      FN

      req.example = <<-EOF
# Simply post item's text
curl -X POST \\
  -F'json={ "text" : "Some inline text" }' \\
  'https://api.ingeniapi.com/v2/items?api_key=$api_key&classify=true'

# Create an item with some text and assign a tag ('foo') to it with a score of 0.2.
curl -X POST \\
  -F'json={ "text" : "Some inline text" , "tags" : { "foo" : 0.2 } }' \\
  'https://api.ingeniapi.com/v2/items?api_key=$api_key&classify=true'

# Create an item with some text, create a new tag set ('my tag set') and add
# a tag ('foo') with a score of 0.2 to that tag set..
curl -X POST \\
  -F'json={ "text" : "Some inline text" , "tag_sets" : { "my tag set" :  { "foo" : 0.2 } } }' \\
  'https://api.ingeniapi.com/v2/items?api_key=$api_key&classify=true'

# Create an item with the tag ('foo')
curl -X POST \\
  -F'json={ "text" : "Some inline text" , "tags" : [ "foo"]  }' \\
  'https://api.ingeniapi.com/v2/items=$api_key&classify=true'

# Post url to retrieve content from and create an item with that content
curl -X POST \\
  -F'json={ "url" : "https://www.zdziarski.com/blog/?p=3875" }' \\
  'https://api.ingeniapi.com/v2/items?api_key=$api_key'

# Post a file using multipart/form-data upload and create an item with that content
curl -X POST \\
  -F'json={}' \\
  -F'file=@article.txt' \\
  'https://api.ingeniapi.com/v2/items?api_key=$api_key&classify=true&update_existing=true'
      EOF
      req.response = json_item

    end

    r.request name: 'Update' do |req|
      req.description = 'Update an existing item'
      req.call_type   = :put
      req.path        = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to update'
        p.type        = :string
        p.required    = true
      end

      req.parameter json_item

      req.parameter name: 'file' do |p|
        p.description = 'File to be used as text source. Sent as multipart upload. Accepted file types are: Text (txt), Postscript Document Format (pdf), Microsoft Office Documents (doc, docx, xls, xlsx, ppt, pptx). [1]'
        p.type        = :multipart
      end

      req.footnote =<<-FN
        <p>[1] You can input content as ONE of: text, a URL, a file (formats
        supported include txt, html, pdf, all the MS Office formats). If you
        send a URL, Ingenia will extract the most meaningful text from it,
        e.g., ignoring links. If you send a file, it will extract the text
        from it.</p>
        <p>The text and the URL are input as part of the JSON component. The file
        is sent as a multipart encoded https field.</p>
      FN

      req.example = <<-EOF
curl -X PUT \\
-F'json={ "text" : "Some updated text" , "tags" : [ "foo"]  }' \\
'https://api.ingeniapi.com/v2/items/61265a8b2e56ff9693753fd044630ed5?api_key=$api_key

Response:

{
  "bundle_id": 778,
  "created_at": "2016-05-10T15:35:59Z",
  "id": "61265a8b2e56ff9693753fd044630ed5",
  "last_classified_at": "2016-05-10T16:54:56Z",
  "updated_at": "2016-05-10T16:54:57Z",
  "text": "Some updated text",
  "tag_sets": [
    {
      "Technologia": {
        "id": 2860,
        "tags": [
          {
            "id": 189475,
            "name": "foo",
            "user_selected": "t",
            "user_assigned": true,
            "score": "0.0",
            "machine_score": "0",
            "rule_score": null,
            "user_assigned_score": "0"
          }
        ]
      }
    }
  ]
}
      EOF

      req.response = json_item
    end

    r.request name: 'Delete' do |req|
      req.description = 'Delete an existing item'
      req.call_type   = :delete
      req.path        = '/items/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the item you want to delete'
        p.type        = :string
        p.required    = true
      end

      req.example = <<-EOF
curl -X DELETE 'https://api.ingeniapi.com/v2/items/61265a8b2e56ff9693753fd044630ed5?api_key=$api_key'

Response:

{
  "61265a8b2e56ff9693753fd044630ed5": "destroyed",
  "bundle_id": 778
}
      EOF
    end
  end

  ##
  # Bundles
  #
  api.resource name: 'Bundles' do |r|
    r.description = "Groups of thematically consistent items"

    r.request name: 'Index' do |req|
      req.description = 'Returns a list of all your bundles'
      req.call_type   = :get
      req.path        = '/bundles'
      req.parameter limit
      req.parameter offset
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/bundles?api_key=$api_key'

Response:

'{
  [
    {
      "id":755,
      "name":"New Bundle",
      "tag_sets" : [
        { "name" : "technology", "id": 14562 },
        { "name" : "business", "id": 666 }
      ],
      "created_at" : "2016-04-06T09:00:44Z",
      "updated_at":"2016-04-06T09:00:44Z"
    },
    {
      "id" : 756,
      "name" : "Another Bundle",
      "tag_sets" : [
        { "name" : "technology", "id": 14562 }
      ],
      "created_at" : "2016-04-07T11:44:26Z",
      "updated_at":"2016-04-07T11:44:26Z"
    }
  ]
}'
      EOF
      req.response = json_bundle_show
    end

    r.request name: 'Show' do |req|
      req.description = 'Returns a single bundle'
      req.call_type   = :get
      req.path        = '/bundles/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to show'
        p.type        = :integer
        p.required    = true
      end

      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/bundles/47858?api_key=$api_key'

Response:

'{
    "id" : 47858,
    "name" : "Tech Startups",
    "tag_sets" : [
      { "name" : "technology", "id": 14562 },
      { "name" : "business", "id": 666 }
    ],
    "created_at" :"2014-03-13T15:36:51Z",
    "updated_at" :"2014-03-13T15:36:51Z",
  }'
      EOF
      req.response = json_bundle_show
    end

    r.request name: 'Find_by_name' do |req|
      req.description = 'Looks for a bundle that matches exactly text input'
      req.call_type   = :get
      req.path        = '/bundles/find_by_name'

      #req.parameter api_key
      req.parameter name: 'text' do |p|
        p.description = 'Text of the bundle to look for'
        p.type        = :string
        p.required    = true
      end

      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/bundles/find_by_name?name=Tech%20Startups&api_key=$api_key'

Response:

'{
    "id" : 47858,
    "name" : "Tech Startups",
    "tag_sets" : [
      { "name" : "technology", "id": 14562 },
      { "name" : "business", "id": 666 }
    ],
    "created_at" :"2014-03-13T15:36:51Z",
    "updated_at" :"2014-03-13T15:36:51Z",
  }'
      EOF
      req.response = json_bundle_show
    end

    r.request name: 'Create' do |req|
      req.description = 'Creates a new bundle'
      req.call_type   = :post
      req.path        = '/bundles'
      req.parameter json_bundle
      req.example = <<-EOF
curl -X POST \\
  -F'json={ "name" : "New Bundle", "tag_set_ids" : [2820, 2819] }' \\
  'https://api.ingeniapi.com/v2/bundles?api_key=$api_key'

Response:

'{
    "id" : 47858,
    "name" : "New Bundle",
    "tag_sets" : [
      {
        "id" : 2820,
        "name" : "Tag Set One"
      },
      {
        "id : 2819,
        "name : "Tag Set Two"
      }
    ],
    "created_at" :"2014-03-13T15:36:51Z",
    "updated_at" :"2014-03-13T15:36:51Z"
  }'
      EOF
      req.response = json_bundle
    end

    r.request name: 'Update' do |req|
      req.description = 'Update an existing bundle'
      req.call_type   = :put
      req.path        = '/bundles/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to update'
        p.type        = :integer
        p.required    = true
      end
      req.parameter json_bundle
      req.example = <<-EOF
curl -X PUT \\
  -F'json={ "name" : "New Bundle Updated" }' \\
  'https://api.ingeniapi.com/v2/bundles/47858?api_key=$api_key'

Response:

'{
    "id" : 47858,
    "name" : "New Bundle Updated",
    "tag_sets" : [
      {
        "id" : 2820,
        "name" : "Tag Set One"
      },
      {
        "id : 2819,
        "name : "Tag Set Two"
      }
    ],
    "created_at" :"2016-04-06T09:00:44Z",
    "updated_at" :"2016-04-06T09:00:44Z",
  }'
      EOF
      req.response = json_bundle
    end

    r.request name: 'Delete' do |req|
      req.description = 'Delete an existing bundle'
      req.call_type   = :delete
      req.path        = '/bundles/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the bundle you want to delete'
        p.type        = :integer
        p.required    = true
        req.example = <<-EOF
curl -X DELETE \\
  'https://api.ingeniapi.com/v2/bundles/47858?api_key=$api_key'

Response:

'{
    "47858" : "destroyed"
  }'
      EOF
      end
    end
  end

  ##
  # Tags
  #
  api.resource name: 'Tags' do |r|
    r.description = "Tags are meaningful words or expressions that you want to associate to some of your items"

    r.request name: 'Index' do |req|
      req.description = 'List all your tags'
      req.call_type   = :get
      req.path        = '/tags'

      req.parameter limit
      req.parameter offset
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/tags?api_key=$api_key'

Response:

[
  {
    "confidence": 0.0,
    "created_at": "2016-05-04T16:12:43Z",
    "current_state": "not_enough_items_to_learn",
    "description": "a term for data sets that are so large or complex that traditional data processing applications are inadequate",
    "id": 189453,
    "name": "Big Data",
    "tag_set_id": 2858,
    "updated_at": "2016-05-04T16:12:43Z"
  },
  {
    "confidence": 0.0,
    "created_at": "2016-05-04T16:08:05Z",
    "current_state": "not_enough_items_to_learn",
    "description": "the process of deriving high-quality information from text",
    "id": 189452,
    "name": "Text Analytics",
    "tag_set_id": 2858,
    "updated_at": "2016-05-04T16:08:05Z"
  }
]
      EOF
      req.response = json_tag_show
    end

    r.request name: 'Show' do |req|
      req.description = 'View a single tag'
      req.call_type   = :get
      req.path        = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to show'
        p.type        = :integer
        p.required    = true
      end
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/tags/189453?api_key=$api_key'

Response:

  {
    "confidence": 0.0,
    "created_at": "2016-05-04T16:12:43Z",
    "current_state": "not_enough_items_to_learn",
    "description": "",
    "id": 189453,
    "name": "New Tag",
    "tag_set_id": 2858,
    "updated_at": "2016-05-04T16:12:43Z"
  }
      EOF
      req.response = json_tag_show
    end

    r.request name: 'Find_by_name' do |req|
      req.description = 'Looks for a tag that matches exactly text input'
      req.call_type   = :get
      req.path        = '/tags/find_by_name'

      req.parameter name: 'text' do |p|
        p.description = 'Text of the tag to look for'
        p.type        = :string
        p.required    = true
      end

      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/tags/find_by_name?name=New%20Tag&api_key=$api_key'

Response:

  {
    "confidence": 0.0,
    "created_at": "2016-05-04T16:12:43Z",
    "current_state": "not_enough_items_to_learn",
    "description": "",
    "id": 189453,
    "name": "New Tag",
    "tag_set_id": 2858,
    "updated_at": "2016-05-04T16:12:43Z"
  }
      EOF
      req.response = json_tag_show
    end

    r.request name: 'Create' do |req|
      req.description = 'Create a new tag'
      req.call_type   = :post
      req.path        = '/tags'

      req.parameter json_tag
      req.example = <<-EOF
curl -X POST \\
  -F'json={ "tag_set_id" : 2858, "name" : "New Tag" }' \\
  'https://api.ingeniapi.com/v2/tags?api_key=$api_key'

Response:

  {
    "confidence": 0.0,
    "created_at": "2016-05-04T17:05:18Z",
    "current_state": "unprocessed",
    "description": "",
    "id": 189455,
    "name": "New Tag",
    "tag_set_id": 2858,
    "updated_at": "2016-05-04T17:05:18Z"
  }
      EOF
      req.response = json_tag
    end

    r.request name: 'Update' do |req|
      req.description = 'Update an existing tag'
      req.call_type   = :put
      req.path        = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to update'
        p.type        = :integer
        p.required    = true
      end
      req.parameter json_tag
      req.example = <<-EOF
curl -X PUT \\
  -F'json={ "name" : "New Tag Updated" }' \\
  'https://api.ingeniapi.com/v2/tags/189453?api_key=$api_key'

Response:

  {
    "confidence": 0.0,
    "created_at": "2016-05-04T16:12:43Z",
    "current_state": "unprocessed",
    "description": "",
    "id": 189453,
    "name": "New Tag Updated",
    "tag_set_id": 2858
  }
      EOF
      req.response = json_tag
    end

    r.request name: 'Merge' do |req|
      req.description = 'Merge two or more existing tags'
      req.call_type   = :post
      req.path        = '/tags/:id/merge'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag into which you want to merge other tags; the resulting tag will have this name'
        p.type        = :integer
        p.required    = true
      end

      req.parameter name: 'tag_ids' do |p|
        p.description = 'A JSON encoded array of tag IDs that will be merged into the main tag'
        p.type        = :array
        p.example     = '[ 23, 43, 2113 ]'
        p.required    = true
      end

      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/tags/189454/merge?tag_ids=%5B189452%2C189453%5D&api_key=$api_key'

/*(Where:
   '%5B' = '['
   '%2C' = ','
   '%5D' = ']'
  for constructing array of IDs in url params)*/

Response:

  {
    "189454":"merged"
  }
      EOF
    end

    r.request name: 'Delete' do |req|
      req.description = 'Delete an existing tag'
      req.call_type   = :delete
      req.path        = '/tags/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag you want to delete'
        p.type        = :integer
        p.required    = true
      end

      req.example = <<-EOF

curl -X DELETE 'https://api.ingeniapi.com/v2/tags/189454?api_key=$api_key'

Response:

  {
    "189455" : "destroyed"
  }
      EOF
    end
  end

  ##
  # Tag rules
  #
  api.resource name: 'Tag rules' do |r|
    r.description = "Tag rules are rules that you want to associate with a tag to influence the tag choice"

    r.request name: 'Index For User' do |req|
      req.description = "List all of the current user's tag rules, organised by tag."
      req.call_type   = :get
      req.path        = '/tag_rules'

      req.response = json_tag_rules_show
      req.example  = <<-EOF
curl https://api.ingeniapi.com/v2/tag_rules?api_key=$api_key

Response:

[
  {
    "id": 189879,
    "name": "Questions",
    "rules": [
      {
        "id": 10963,
        "tag_rule_mode": "word_absent",
        "rule_tag_id": null,
        "word": "help",
        "language": "en",
        "influence": -0.1,
        "created_at": "2016-06-02T18:10:24Z",
        "updated_at": "2016-06-02T18:10:24Z"
      },
      {
        "id": 10964,
        "tag_rule_mode": "word_present",
        "rule_tag_id": null,
        "word": "question",
        "language": "en",
        "influence": 0.1,
        "created_at": "2016-06-02T18:10:24Z",
        "updated_at": "2016-06-02T18:10:24Z"
      }
    ]
  },
  {
    "id": 189840,
    "name": "service improvements",
    "rules": [
      {
        "id": 10783,
        "tag_rule_mode": "word_present",
        "rule_tag_id": null,
        "word": "better",
        "language": "en",
        "influence": 0.1,
        "created_at": "2016-06-02T18:10:24Z",
        "updated_at": "2016-06-02T18:10:24Z"
      },
      {...}
    ]
  },
  {...}
]
EOF
    end

    r.request name: 'Index' do |req|
      req.description = 'List all of your tag rules for a specific tag.'
      req.call_type   = :get
      req.path        = '/tags/:tag_id/tag_rules'

      req.response = json_tag_rules_show
      req.example  = <<-EOF
curl https://api.ingeniapi.com/v2/tags/5/tag_rules?api_key=$api_key

Response:

{
  "tag": {
    "id": 189879,
    "name": "Questions"
  },
  "tag_rules": [
    {
      "id": 10963,
      "tag_rule_mode": "word_absent",
      "rule_tag_id": null,
      "word": "help",
      "language": "en",
      "influence": -0.1,
      "created_at": "2016-06-02T18:10:24Z",
      "updated_at": "2016-06-02T18:10:24Z"
    },
    {
      "id": 10964,
      "tag_rule_mode": "word_present",
      "rule_tag_id": null,
      "word": "question",
      "language": "en",
      "influence": 0.1,
      "created_at": "2016-06-02T18:10:24Z",
      "updated_at": "2016-06-02T18:10:24Z"
    }
  ]
}
      EOF

      req.parameter name: 'tag_id' do |p|
        p.description = 'The ID of the tag to find its associated tag rules'
        p.type        = :integer
        p.required    = true
      end
    end

    r.request name: 'Show' do |req|
      req.description = 'View a single tag rule'
      req.call_type   = :get
      req.path        = '/tags/:tag_id/tag_rules/:id'

      req.response = json_tag_rule_show
      req.example  = <<-EOF
curl https://api.ingeniapi.com/v2/tags/5/tag_rules/6?api_key=$api_key

Response:

{
  "tag": {
    "id": 189879,
    "name": "Questions"
  },
  "tag_rule": {
    "id": 10963,
    "tag_rule_mode": "word_absent",
    "rule_tag_id": null,
    "word": "help",
    "language": "en",
    "influence": -0.1,
    "created_at": "2016-06-02T18:10:24Z",
    "updated_at": "2016-06-02T18:10:24Z"
  }
}
      EOF

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag rule'
        p.type        = :integer
        p.required    = true
      end

      req.parameter name: 'tag_id' do |p|
        p.description = 'The ID of the tag'
        p.type        = :integer
        p.required    = true
      end
    end

    r.request name: 'Create' do |req|
      req.description = 'Create a new tag rule'
      req.call_type   = :post
      req.path        = '/tags/:tag_id/tag_rules'

      req.response = json_tag_rule_create
      req.example = <<-EOF
curl -X POST \\
  -F'json={ "text": "tag_text", "influence" : 0.3, "language": "en", "tag_rule_mode": "word_present" }' \\
  https://api.ingeniapi.com/v2/tags/5/tag_rules?api_key=$api_key
      EOF

      req.parameter name: 'tag_id' do |p|
        p.description = 'The ID of the tag'
        p.type        = :integer
        p.required    = true
      end
    end

    r.request name: 'Delete' do |req|
      req.description = 'Delete an existing tag rule'
      req.call_type   = :delete
      req.path        = '/tags/:tag_id/tag_rules/:id'
      req.example     = <<-EOF
curl -X DELETE \\
  https://api.ingeniapi.com/v2/tags/5/tag_rules/6?api_key=$api_key
      EOF

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag rule you want to delete'
        p.type        = :integer
        p.required    = true
      end

      req.parameter name: 'tag_id' do |p|
        p.description = 'The ID of the tag'
        p.type        = :integer
        p.required    = true
      end
    end
  end

  ##
  # Tag Sets
  #
  api.resource name: 'Tag sets' do |r|
    r.description = "Tag sets are thematically consistent groups of tags defined by you, such as, say, world countries, business sectors, product types, companies, concepts, topics, etc"

    r.request name: 'Index' do |req|
      req.description = 'List all your tag sets'
      req.call_type   = :get
      req.path        = '/tag_sets'

      req.parameter limit
      req.parameter offset
      req.example = <<-EOF
# Simple request to fetch all tag sets
curl -s -q 'https://api.ingeniapi.com/v2/tag_sets?api_key=$api_key'

# ...and a bit more advanced example
curl -s -q 'https://api.ingeniapi.com/v2/tag_sets?limit=100&offset=100&bundle_id=42&api_key=$api_key'

Response:

'[
  {
    "created_at" : "2016-04-06T11:01:18Z",
    "id" : 2820,
    "name" : "Tag Set One",
    "updated_at" : "2016-04-06T11:04:00Z"
    "bundles": [
      {
        "id": 773,
        "name": "Some Bundle"
      },
      {
        "id": 774,
        "name": "Some Other Bundle"
      }
    ]
  },
  {
    "created_at" : "2016-04-06T09:00:44Z",
    "id" : 2819,
    "name" : "Tag Set Two",
    "updated_at":"2016-04-06T09:00:44Z",
    "bundles": [
      {
        "id": 773,
        "name": "A Different Bundle"
      }
    ]
  }
]'
      EOF
      req.response = json_tag_set_show
    end

    r.request name: 'Show' do |req|
      req.description = 'View a single tag set'
      req.call_type   = :get
      req.path        = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to show'
        p.type        = :integer
        p.required    = true
      end
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/tag_sets/2820?api_key=haDJdWeW41iwzEup7n8x'

Response:

{
  "created_at": "2016-05-04T11:30:43Z",
  "id": 2857,
  "name": "New Tag Set",
  "updated_at": "2016-05-04T12:52:56Z",
  "bundles": [
    {
      "id": 773,
      "name": "Prodotti"
    },
    {
      "id": 774,
      "name": "Articoli"
    }
  ]
}
EOF
      req.response = json_tag_set_show
    end

    r.request name: 'Find_by_name' do |req|
      req.description = 'Looks for a tag set that matches exactly text input'
      req.call_type   = :get
      req.path        = '/tag_sets/find_by_name'

      req.parameter name: 'text' do |p|
        p.description = 'Text of tag set to look for'
        p.type        = :string
        p.required = true
      req.example = <<-EOF
curl 'https://api.ingeniapi.com/v2/tag_sets/find_by_name?name=Big%20Data&api_key=$api_key'

Response:

'{
  "created_at" : "2016-04-07T16:13:52Z",
  "id" : 2822,
  "name" : "Big Data",
  "updated_at" : "2016-04-07T16:13:52Z"
  "bundles": [
    {
      "id": 773,
      "name": "A Bundle Name"
    }
  ]
}'
      EOF
      req.response = json_tag_set_show
      end

    end

    r.request name: 'Create' do |req|
      req.description = 'Create a new tag set'
      req.call_type   = :post
      req.path        = '/tag_sets'

      req.parameter json_tag_set
      req.example = <<-EOF
curl -s -X POST \\
  -F'json={ "name" : "new tag s" }' \\
  'https://api.ingeniapi.com/v2/tag_sets?api_key=$api_key'

Response:

'{
  "created_at" : "2016-04-07T16:49:24Z",
  "id" : 2823,
  "name" : "new tag s",
  "updated_at" : "2016-04-07T16:49:24Z"
}'
      EOF
      req.response = json_tag_set
    end

    r.request name: 'Update' do |req|
      req.description = 'Update an existing tag set'
      req.call_type   = :put
      req.path        = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to update'
        p.type        = :integer
        p.required    = true
      end

      req.parameter json_tag_set
      req.example = <<-EOF
curl -s -X PUT \\
  -F'json={ "name" : "Updated Tag Set Name" }' \\
  'https://api.ingeniapi.com/v2/tag_sets/2823?api_key=$api_key'

Response:

'{
  "created_at" : "2016-04-07T16:49:24Z",
  "id" : 2823,
  "name" : "Updated Tag Set Name",
  "updated_at" : "2016-04-07T16:58:11Z"
}'
      EOF
      req.response = json_tag_set
    end

    r.request name: 'Merge' do |req|
      req.description = 'Merge two or more existing tag sets'
      req.call_type   = :post
      req.path        = '/tag_sets/:id/merge'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set into which you want to merge the other tag sets; the resulting tag set will have this name'
        p.type        = :integer
        p.required    = true
      end

      req.parameter name: 'tag_set_ids' do |p|
        p.description = 'JSON encoded array of tag set IDs to merge into main tag set'
        p.type        = :array
        p.example     = '[ 12, 34, 56 ]'
        p.required    = true
      end

      req.example = <<-EOF

curl -X POST 'https://api.ingeniapi.com/v2/tag_sets/2824/merge?tag_set_ids=%5B2833%2C2832%5D&api_key=$api_key'

/*(Where:
 '%5B' = '['
 '%2C' = ','
 '%5D' = ']'
for constructing array of IDs in url params)*/

Response:

'{
  {"tag_set_id" : 2824}
}'
      EOF
    end

    r.request name: 'Delete' do |req|
      req.description = 'Delete an existing tag set'
      req.call_type   = :delete
      req.path        = '/tag_sets/:id'

      req.parameter name: 'id' do |p|
        p.description = 'The ID of the tag set you want to delete.'
        p.type        = :integer
        p.required    = true
      end

      req.example = <<-EOF

curl -X DELETE 'https://api.ingeniapi.com/v2/tag_sets/2824?api_key=$api_key'

Response:

'{
  "2824" : "destroyed"
}'
      EOF
    end
  end

  api.resource name: 'Text extraction' do |r|
    r.description = "Returns stripped text for a given url"

    r.request name: 'Get stripped text' do |req|
      req.description = 'Returns stripped text for a given url'
      req.call_type   = :post

      req.parameter uri
      req.example = <<-EOF
# Request to get stripped content for url
curl -X POST -H 'Content-Type: application/json' -d '{"url":{"uri":"https://techcrunch.com/2016/08/02/instagram-stories/"}}' http://content-service.ingeniapi.com/urls

Response:

'{
  "url": {
    "uri": "https://techcrunch.com/2016/08/02/instagram-stories/"
  },
  "title": "Instagram launches “Stories,” a Snapchatty feature for imperfect sharing",
  "content": "People only post the highlights of their life on Instagram, so today the app adds its own version of “Stories” ...'
      EOF
    end

    r.request name: 'Get full html' do |req|
      req.description = 'Returns full html for a url'
      req.call_type   = :get

      req.parameter url
      req.example = <<-EOF
# Request to get stripped content for url
curl 'https://techcrunch.com/2016/08/02/instagram-stories/'

Response:
<xmp>'<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://opengraphprotocol.org/schema/" xmlns:fb="http://www.facebook.com/2008/fbml" lang="en">
<head>
  <title>Instagram launches &#8220;Stories,&#8221; a Snapchatty feature for imperfect sharing  |  TechCrunch</title>
  ...'</xmp>
      EOF
    end
  end

  ##
  # Administrative Calls
  #
  api.resource name: 'Administrative calls' do |r|
    r.description = ""

    r.request name: 'Status' do |req|
      req.description = 'The status of your Ingenia account, indicating whether Ingenia has processed all your content; use this to test your API key, see [status call] for details'
      req.call_type   = :get
      req.path        = '/status'

      req.parameter name: 'total_bundles' do |p|
        p.description = 'Number of bundles you have own'
        p.type        = :integer
      end

      req.parameter name: 'processed_bundles' do |p|
        p.description = 'Number of bundles where all items have been processed'
        p.type        = :integer
      end

      req.parameter name: 'total_items' do |p|
        p.description = 'Number of items you have created'
        p.type        = :integer
      end

      req.parameter name: 'pending_items' do |p|
        p.description = 'Number of items Ingenia has not yet processed'
        p.type        = :integer
      end

      req.parameter name: 'processed_items' do |p|
        p.description = 'Number of items Ingenia has processed'
        p.type        = :integer
      end

      req.parameter name: 'total_tag_sets' do |p|
        p.description = 'Number of tag sets you own'
        p.type        = :integer
      end

      req.parameter name: 'processed_tag_sets' do |p|
        p.description = 'Number of tag sets Ingenia has processed'
        p.type        = :integer
      end

      req.parameter name: 'pending_tag_sets' do |p|
        p.description = 'Number of tag sets ready to process, but which Ingenia has not yet processed'
        p.type        = :integer
      end

      req.parameter name: 'untrained_tag_sets' do |p|
        p.description = 'Number of tag sets which do not have enough items to process'
        p.type        = :integer
      end

      req.parameter name: 'idle_tag_sets' do |p|
        p.description = 'Number of tag sets that the user prefers to not be processed by Ingenia'
        p.type        = :integer
      end

      req.parameter name: 'total_tags' do |p|
        p.description = 'Number of tags you have own'
        p.type        = :integer
      end

      req.parameter name: 'processed_tags' do |p|
        p.description = 'Number of tags Ingenia has processed'
        p.type        = :integer
      end

      req.parameter name: 'pending_tags' do |p|
        p.description = 'Number of tags Ingenia has not yet processed'
        p.type        = :integer
      end

      req.parameter name: 'untrained_tags' do |p|
        p.description = 'Number of tags which are not assigned to items'
        p.type        = :integer
      end

      req.parameter name: 'idle_tags' do |p|
        p.description = 'Number of tags that the user prefers to not be processed by Ingenia'
        p.type        = :integer
      end

      req.parameter name: 'ready_to_classify' do |p|
        p.description = 'True if all tags assigned to items have been processed'
        p.type        = :boolean
      end

      req.example = <<-EOF
curl -X GET 'https://api.ingeniapi.com/v2/status?api_key=$api_key'

Response:

{
    "total_bundles": 17,
    "processed_bundles": 1,
    "total_items": 2,
    "pending_items": 0,
    "processed_items": 2,
    "total_tag_sets": 2,
    "pending_tag_sets": 0,
    "processed_tag_sets": 0,
    "untrained_tag_sets": 2,
    "idle_tag_sets": 0,
    "total_tags": 3,
    "pending_tags": 0,
    "processed_tags": 0,
    "untrained_tags": 3,
    "idle_tags": 0,
    "ready_to_classify": true
  }
      EOF
    end


    r.request name: 'Clear_data' do |req|
      req.description = 'Delete all the data in your account; useful to restart from zero if the data was polluted'
      req.call_type   = :post
      req.path        = '/clear_data'
      req.example = <<-EOF
curl -X POST 'https://api.ingeniapi.com/v2/clear_data?api_key=$api_key'

Response:

{}
      EOF
    end

  end

end

@api = api

api.to_json
