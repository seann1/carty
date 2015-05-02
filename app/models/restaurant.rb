class Restaurant < ActiveRecord::Base
	belongs_to :user
	# validates :user_id, :presence => true
	validates_uniqueness_of :name
	# validates_uniqueness_of :address
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

	has_attached_file :avatar,
               storage: :s3,
               :styles => { :medium => "300x300>", :thumb => "100x100>" },
               :default_url => "http://sean-stack.s3.amazonaws.com/missing.png",
               :bucket => ENV['AWS_BUCKET']
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end