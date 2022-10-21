class Types::PostType < Types::BaseObject
  description "One post"

  field :id, ID, null: false
  field :body, String, null: false

  def get_post_id
    object.id
  end

  field :comments, [Types::CommentType], null: false, description: "Returns all comment's posts"

  def comments
    Comment.all.where(post_id: get_post_id)
  end

  field :errors, [Types::ErrorType], null: true

  def errors
    object.errors.map { |e| { field_name: e.attribute, errors: object.errors[e.attribute]} }
  end
end
