class Relationship < ApplicationRecord
	belongs_to :followee, class_name: "User"
end
