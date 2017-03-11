class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :type
      t.integer :book
      t.integer :user
      t.datetime :time

      t.timestamps
    end
  end
end
