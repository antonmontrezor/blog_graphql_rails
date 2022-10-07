module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :user, Types::UserType, null: false, description: "Returns one User instance" do
      argument :id, ID, required: true
    end

    def user(id:)
      User.where(id: id).first
    end

    field :users, [Types::UserType], null: false, description: "Returns all users"

    def users
      User.all
    end

    field :post, Types::PostType, null: false, description: "Returns one Post instance" do
      argument :id, ID, required: true
    end

    def post(user_id:)
      Post.where(id: id).first
    end

    field :comment, Types::CommentType, null: false, description: "Returns one Comment instance" do
      argument :id, ID, required: true
    end

    def comment(id:)
      Comment.where(id: id)
    end
  end
end
