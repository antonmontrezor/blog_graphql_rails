class Mutations::CreateUser < GraphQL::Schema::Mutation
  null true

  argument :user, Types::UserInputType, required: true

  # this mutation is its own class, it doesn't have a resolver called create_user, but we can use the standart resolve method
  def resolve(user:)
    User.create(user.to_h)
  end
end