class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
	create_table :users do |t|
  		t.string :fname
  		t.string :lname
  		t.datetime :birthday
  		t.string :password
  		t.string :email
  		t.string :address
  		t.boolean :verified
  		t.string :likes
  		t.string :dislikes
  		t.string :experience
  		t.string :language
  		t.string :socialmedia
  		t.string :links
  		t.datetime :lastsignin
  	end
  end
end
