class ChangeBookAttribute < ActiveRecord::Migration
  def up
    remove_column :books, :title, :author
  end

  def down
  end
end
