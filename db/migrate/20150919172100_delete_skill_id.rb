class DeleteSkillId < ActiveRecord::Migration
  def change
    remove_column :tasks, :skill_id, :integer
  end
end
