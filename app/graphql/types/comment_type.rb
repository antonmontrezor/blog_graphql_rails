class Types::CommentType < Types::BaseObject
  description "One comment"

  field :id, ID, null: false
  field :body, String, null: false
end
