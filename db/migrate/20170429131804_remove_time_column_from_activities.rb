class RemoveTimeColumnFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :time
  end
end
