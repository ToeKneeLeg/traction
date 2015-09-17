class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :member
  has_one :skill 
  
  validates :description, :required_skill, presence: true
  validates :description, length: { maximum: 200 }

  after_create do 
    puts "La De Da"
    # member = Member.all
    # member.find do |member|
    #   if member.tasks.empty? && member.skills.exists?(self.required_skill)
    #     self.member_id = member.id 
    #   end
    # end
  end

  # protected

  # def assign_task
  #   self.description = "this worked"
  #  #  puts "La De Da"
  # 	# member = Member.all
  # 	# member.find do |member|
  # 	# 	if member.tasks.empty? && member.skills.exists?(self.required_skill)
  # 	# 		self.member_id = member.id 
  #  #    end
  # 	# end
  # end	

end