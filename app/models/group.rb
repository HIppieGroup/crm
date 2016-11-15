class Group < ApplicationRecord
	has_many 	:users
	has_many 	:tascs, dependent: :destroy
end
