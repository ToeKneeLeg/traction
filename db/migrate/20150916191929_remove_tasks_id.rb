class RemoveTasksId < ActiveRecord::Migration
  def change
    remove_column :projects, :tasks_id
  end
end
