class Types::CommentType < Types::BaseObject
  description "One comment"

  field :id, ID, null: false
  field :body, String, null: false

  field :errors, [Types::ErrorType], null: true

  def errors
    object.errors.map { |e| { field_name: e.attribute, errors: object.errors[e.attribute]} }
  end
end
