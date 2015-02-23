class Listing < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
end
