class AddDescriptionToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :description, :string, { default: "No description" }  
  end
end
