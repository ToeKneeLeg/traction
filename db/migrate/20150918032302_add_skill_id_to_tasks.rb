class AddSkillIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :skill_id, :integer
  end
end
