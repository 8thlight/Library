class AddQuantityLeftToBooks < ActiveRecord::Migration
  def change
    add_column :books, :quantity_left, :integer
  end
end
