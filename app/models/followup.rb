class Followup < ActiveRecord::Base
	belongs_to :user
  	validates :user_id, presence: true
  	#belongs_to :micropost
  	#validates :micropost_id, presence: true
end
