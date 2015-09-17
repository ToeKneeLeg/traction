class Member < ActiveRecord::Base
  has_many :tasks
  has_many :member_skills
end

# @mj.member_skills.find(1).skill.name