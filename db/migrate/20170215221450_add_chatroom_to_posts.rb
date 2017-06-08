class AddChatroomToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :chatroom, foreign_key: true
  end
end
