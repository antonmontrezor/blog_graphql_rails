class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
