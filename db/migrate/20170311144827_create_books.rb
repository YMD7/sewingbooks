class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :status
      t.integer :recommended_by
      t.string :comment
      t.date :recommended_date

      t.timestamps
    end
  end
end
