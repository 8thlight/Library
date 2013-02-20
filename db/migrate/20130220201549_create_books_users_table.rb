class CreateBooksUsersTable < ActiveRecord::Migration
  def self.up
    create_table :books_users, :id => false do |t|
      t.references :book
      t.references :user
    end
    add_index :books_users, [:book_id, :user_id]
    add_index :books_users, [:user_id, :book_id]
  end

  def self.down
    drop_table :books_users
  end
end
