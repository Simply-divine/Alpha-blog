class User < ApplicationRecord
	validates :username, presence:true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 5} 
	VALID_EMAIL_REGEX= /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
						length: {maximum: 105}, 
						uniqueness: {case_sensitive: false},
						format: { with: VALID_EMAIL_REGEX } 
end
	
