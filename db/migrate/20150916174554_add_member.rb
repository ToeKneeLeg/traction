class AddMember < ActiveRecord::Migration
  def change
    create_table "members" do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :skill_one
      t.string :skill_two
      t.string :skill_three
      t.string :skill_four
      t.string :skill_five
    end
  end
end
