class FixPosts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :posts, :content, :string
  end
end
