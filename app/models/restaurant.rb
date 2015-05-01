class Restaurant < ActiveRecord::Base
	belongs_to :user
	# validates :user_id, :presence => true
	validates_uniqueness_of :name
	# validates_uniqueness_of :address
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end