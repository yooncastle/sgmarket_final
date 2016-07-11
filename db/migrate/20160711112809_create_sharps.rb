class CreateSharps < ActiveRecord::Migration
  def change
    create_table :sharps do |t|
      t.integer :post_id
      t.integer :hashtag_id 

      t.timestamps null: false
    end
  end
end
