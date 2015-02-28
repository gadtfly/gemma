class Listing < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	validates :name, :description, :price, :image, presence: true
	validates :price, numericality: { greater_than: 0}
	belongs_to :category
	belongs_to :user
	has_many :orders
end
