class AddPortraitToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :portrait, :string
  end
end
