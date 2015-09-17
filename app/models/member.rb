class Member < ActiveRecord::Base
 
  has_many :tasks
  has_many :member_skills
  has_many :skills, through: :member_skills

  validates :first_name, :last_name, :email, presence: true
  
  def get_task
  	tasks = Task.where(completed: false, member_id: nil)

  	tasks.find do |t|
  		self.skills.exists?(t.required_skill)
  	end
  	task.member_id = member.id
  end

end

