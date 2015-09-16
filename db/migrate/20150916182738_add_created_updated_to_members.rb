class AddCreatedUpdatedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :created_at, :datetime
    add_column :members, :updated_at, :datetime
  end
end
