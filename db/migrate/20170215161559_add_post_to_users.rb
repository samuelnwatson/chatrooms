class AddPostToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :posts, foreign_key: true
  end
end
