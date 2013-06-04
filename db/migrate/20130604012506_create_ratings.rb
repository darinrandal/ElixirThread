class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :rating_type

      t.timestamps
    end
  end
end
