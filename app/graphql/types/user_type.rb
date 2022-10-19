class Types::UserType < Types::BaseObject
  description "One user"

  field :id, ID, null: false
  field :first_name, String, null: false
  field :last_name, String, null: false
  field :street, String, null: false
  field :number, Integer, null: false
  field :city, String, null: false
  field :postcode, String, null: false
  field :country, String, null: false

  def get_user_id
    object.id
  end

  # creating a field with a resolver here
  field :posts, [Types::PostType], null: false, description: "Returns all user's posts"

  def posts
    Post.all.where(user_id: get_user_id)
  end

  field :address, String, null: false

  def address
    "#{object.number} #{object.street}, #{object.city}, #{object.postcode}, #{object.country}"
  end
end

class Types::UserInputType < GraphQL::Schema::InputObject
  # the name is what seen by the front-end client, for ex graphiql
  # if we want it not to be nilable, when we call this type in graphiql, it's needed to include "!" like so mutation createUser($user:UserInputType!) {
  graphql_name "UserInputType"
  description "All the attributes needed to create/update an user"

  argument :id, ID, required: false
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :street, String, required: false
  argument :number, Integer, required: false
  argument :city, String, required: false
  argument :postcode, String, required: false
  argument :country, String, required: false
end
