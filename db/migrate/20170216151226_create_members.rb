class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.belongs_to :chatroom, index: true, unique: true
      t.belongs_to :user, index: true, unique: true
      t.timestamps
    end
    add_index(:members, [:user_id, :chatroom_id], unique: true)
  end
end
