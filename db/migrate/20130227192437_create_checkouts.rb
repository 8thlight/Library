class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :book_id
      t.integer :user_id
      t.datetime :check_out_date

      t.timestamps
    end
  end
end
