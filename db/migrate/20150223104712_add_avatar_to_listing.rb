class AddimageToListing < ActiveRecord::Migration
  def change
    add_column :listings, :image, :string
  end
end
