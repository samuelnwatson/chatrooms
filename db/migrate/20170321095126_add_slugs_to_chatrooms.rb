class AddSlugsToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :slug, :string
    add_index :chatrooms, :slug, unique: true
  end
end
