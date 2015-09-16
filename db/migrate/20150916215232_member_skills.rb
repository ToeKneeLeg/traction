class MemberSkills < ActiveRecord::Migration
  def change
  	create_table "member_skills" do |t|
  		t.references :member
  		t.references :skill 
  	end
  end
end
