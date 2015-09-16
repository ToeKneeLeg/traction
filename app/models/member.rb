class Member < ActiveRecord::Base
  has_many :tasks
  has_many :skills
end