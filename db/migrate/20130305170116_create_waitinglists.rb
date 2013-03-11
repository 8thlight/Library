class CreateWaitinglists < ActiveRecord::Migration
  def change
    create_table :waitinglists do |t|
      t.integer :book_id
      t.integer :user_id
      t.datetime :wait_since

      t.timestamps
    end
  end
end
