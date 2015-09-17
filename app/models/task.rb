class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :member
  
  validates :description, :required_skill, presence: true
  validates :description, length: { maximum: 200 }
  after_create :assign_task
end