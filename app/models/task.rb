class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :member
  has_one :skill 
  
  validates :description, :required_skill, presence: true
  validates :description, length: { maximum: 200 }

  before_create :assign_task
  
  def assign_task
  	member = Member.all
  	member.find do |member|
  		if member.tasks.empty? && member.skills.exists?(self.required_skill)
  			self.member_id = member.id 
      end 
  	end
  end	

end