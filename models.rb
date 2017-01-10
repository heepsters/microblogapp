class User < ActiveRecord::Base
	has_many :posts
	validates :content, length:{maximum: 150}
end

class Post < ActiveRecord::Base
	belongs_to :user
end

