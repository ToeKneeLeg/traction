class RemoveMemberSkill12345 < ActiveRecord::Migration
  def change
  	remove_column :members, :skill_one
  	remove_column :members, :skill_two
  	remove_column :members, :skill_three
  	remove_column :members, :skill_four
  	remove_column :members, :skill_five
  end
end
