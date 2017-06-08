class ChangePostContentValidation < ActiveRecord::Migration[5.0]
    def up
      add_column :posts, :content, :string
    end

    def down
      remove_column :posts, :content, :string
    end
end
