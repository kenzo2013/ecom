class AddRowProductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :row_product, :integer
  end
end
