class AddUserToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :chatrooms, :user, foreign_key: true
  end
end
