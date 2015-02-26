class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.integer :user_id
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
