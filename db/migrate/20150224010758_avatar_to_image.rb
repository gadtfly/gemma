class imageToImage < ActiveRecord::Migration
  def change
  	rename_column :listings, :image, :image
  end
end
