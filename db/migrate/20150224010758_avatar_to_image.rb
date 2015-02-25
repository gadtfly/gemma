class AvatarToImage < ActiveRecord::Migration
  def change
  	rename_column :listings, :avatar, :image
  end
end
