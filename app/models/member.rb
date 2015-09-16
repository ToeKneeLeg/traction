class Member < ActiveRecord::Base
  has_many :tasks
  validates :skill_one, :skill_two, :skill_three, presence: true
end