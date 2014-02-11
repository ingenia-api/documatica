entity do
  name: 'item'
  description: 'a units of your textual content on the ingenia system'

  field :id, 'unique identified for this item'
  field :text, 'the text of this item', :max_length => 9000
end