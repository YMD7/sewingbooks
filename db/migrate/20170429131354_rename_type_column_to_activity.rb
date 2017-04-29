class RenameTypeColumnToActivity < ActiveRecord::Migration[5.0]
  def change
    rename_column :activities, :type, :status
  end
end
