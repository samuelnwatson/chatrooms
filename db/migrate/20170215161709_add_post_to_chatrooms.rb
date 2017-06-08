class AddPostToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :chatrooms, :posts, foreign_key: true
  end
end
