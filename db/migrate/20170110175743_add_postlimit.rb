class AddPostlimit < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :content, :string, :limit => 150
  end
end
