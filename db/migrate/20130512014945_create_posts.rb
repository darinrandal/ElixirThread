class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.boolean :visible, :default => true

      #Post logging
      t.string :os
      t.string :browser
      t.string :country_code

      t.timestamps
    end
  end
end
