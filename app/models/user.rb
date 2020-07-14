class User < ApplicationRecord
	has_many :facts

	validates :username, presence: true
	validates :password, presence: true
end
