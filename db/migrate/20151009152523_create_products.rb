class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :weight
      t.decimal :price
      t.text :description
      t.string :tag_1
      t.string :tag_2
      t.string :tag_3

      t.timestamps null: false
    end
  end
end
