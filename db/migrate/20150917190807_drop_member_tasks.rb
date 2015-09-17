class DropMemberTasks < ActiveRecord::Migration
  def change
  	drop_table :member_tasks
  end
end
