class AddProjects < ActiveRecord::Migration
  def change
    create_table "projects" do |t|
      t.references :tasks
      t.string :name
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
