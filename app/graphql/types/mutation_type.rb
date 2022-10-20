module Types
  class MutationType < Types::BaseObject

    field :create_user, Types::UserType, mutation: Mutations::CreateUser

    field :update_user, Boolean, null: false, description: "Update a User" do
      argument :user, Types::UserInputType, required: true
    end

    # since the argument is user (whole object), we convert it to hash for grapthQl
    def update_user(user:)
      existing_user = User.where(id: user[:id])
      existing_user&.update(user.to_h)
    end

    field :delete_user, Boolean, null: false, description: "Delete a specific User" do
      argument :user_id, ID, required: true
    end

    def delete_user(user_id:)
      User.where(id: user_id).destroy
    end

    field :create_post, Types::PostType, null: false, description: "Create a post for a specific User" do
      argument :user_id, ID, required: true
      argument :body, String, required: true
    end

    def create_post(user_id:, body:)
      User.where(id: user_id).first.posts.create(body: body)
    end

    field :update_post, Boolean, null: false, description: "Update a Post" do
      argument :post_id, ID, required: true
      argument :body, String, required: true
    end

    # we don't need to convert anything as we just update the value of an attribute body
    def update_post(post_id:, body:)
      existing_post = Post.where(id: post_id)
      existing_post&.update(body: body)
    end

    field :delete_post, Boolean, null: false, description: "Delete a specific Post" do
      argument :post_id, ID, required: true
    end

    def delete_post(post_id:)
      # this way we specify exact record to be deleted
      Post.destroy(post_id)
    end

    field :create_comment, Types::CommentType, null: false, description: "Create a comment under a specific Post" do
      argument :post_id, ID, required: true
      argument :body, String, required: true
    end

    def create_comment(post_id:, body:)
      Post.where(id: post_id).first.comments.create(body: body)
    end

    field :update_comment, Boolean, null: false, description: "Update a Comment" do
      argument :comment_id, ID, required: true
      argument :body, String, required: true
    end

    # we don't need to convert anything as we just update the value of an attribute body
    def update_comment(comment_id:, body:)
      existing_comment = Comment.where(id: comment_id)
      existing_comment&.update(body: body)
    end

    field :delete_comment, Boolean, null: false, description: "Delete a specific Comment" do
      argument :comment_id, ID, required: true
    end

    def delete_comment(comment_id:)
      Comment.destroy(comment_id)
    end
  end
end
