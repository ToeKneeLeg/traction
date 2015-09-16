class CreateTask < ActiveRecord::Migration
  def change
    create_table "tasks" do |t|
      t.references :project
      t.references :member
      t.string :description
      t.string :required_skill
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
