class AddCompletedColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :completed, :boolean
  end
end
