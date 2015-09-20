class Member < ActiveRecord::Base
 
  has_many :tasks
  has_many :member_skills, dependent: :destroy
  has_many :skills, through: :member_skills

  validates :first_name, :last_name, :email, presence: true
  
  before_destroy :remove_memberid_from_tasks

  def remove_memberid_from_tasks
    tasks_assigned_to_member = self.tasks
    tasks_assigned_to_member.each do |task|
      task.member_id = nil
      task.save
    end
  end

  # after_create :get_task

  # def get_task
  # 	tasks = Task.where(completed: false, member_id: nil)
  #   # member = Member.where()
  #   member_id = nil
  # 	unassigned_task = tasks.find do |t|
  #                     self.skills.exists?(self.skill_id)
  #                     end
  # 	unassigned_task.member_id = self.id
  #   unassigned_task.save
  # end

end

