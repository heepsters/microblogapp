class CreateProfilesTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :profiles do |t|
  		t.string :likes
  		t.string :dislikes
  		t.string :languages	
  		t.integer :user_id
  	end
  end
end
