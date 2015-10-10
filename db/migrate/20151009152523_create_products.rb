class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :weight
      t.integer :price
      t.text :description
      t.string :image
      t.string :category_ids
      t.string :tag_list_ids
      t.string :state, :default => "visible"
      t.timestamps null: false
    end
  end
end
