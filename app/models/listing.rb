class Listing < ActiveRecord::Base
	belongs_to :user
	mount_uploader :image, ImageUploader

	validates :name, :description, :price, :image, presence: true
	validates :price, numericality: { greater_than: 0}
	belongs_to :category
end
