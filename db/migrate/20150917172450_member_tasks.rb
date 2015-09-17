class MemberTasks < ActiveRecord::Migration
  def change
  	create_table "member_tasks" do |t|
  		t.references :member 
  		t.references :task 
  	end
  end
end
