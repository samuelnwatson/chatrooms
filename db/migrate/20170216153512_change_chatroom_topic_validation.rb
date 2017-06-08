class ChangeChatroomTopicValidation < ActiveRecord::Migration[5.0]
    def change
      add_index :chatrooms, :topic, unique: true
    end
end
