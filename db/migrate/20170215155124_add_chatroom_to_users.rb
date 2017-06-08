class AddChatroomToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :chatroom, foreign_key: true
  end
end
