class CreateCheckOuts < ActiveRecord::Migration
  def change
    create_table :check_outs do |t|
      t.integer :book_id
      t.integer :user_id
      t.datetime :check_out_date

      t.timestamps
    end
  end
end
