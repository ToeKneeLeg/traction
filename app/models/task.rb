class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :member
  belongs_to :skill 
  
  validates :description, :skill_id, presence: true
  validates :description, length: { maximum: 200 }

  after_create :assign_task
  
  def assign_task
  	member = Member.all
    selected_member = nil
  	member.find do |member|
  		if (member.tasks.count <= 2) && member.skills.exists?(self.skill_id)
  			selected_member = member.id 
      end 
  	end
    self.member_id = selected_member
    self.save
  end	
end
