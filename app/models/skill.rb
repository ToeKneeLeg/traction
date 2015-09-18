class Skill < ActiveRecord::Base

  has_many :tasks, dependent: :destroy
  has_many :member_skills, dependent: :destroy
  has_many :members, through: :member_skills

	validates :name, presence: true


end