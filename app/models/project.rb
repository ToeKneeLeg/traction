class Project < ActiveRecord::Base
  has_many :tasks
  validates :name, :description, presence: true
  validates :description, length: { maxiumum: 140 }
  validates :name, length: { maximum: 40 }
end
