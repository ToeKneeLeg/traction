require 'faker'
SKILLS = ["JavaScript","Ruby","Ruby on Rails", "Sinatra", "HTML/CSS"]
NAMES = ["Make Website","Write Book", "Conquer World", "Demo Killer App"]

NAMES.each do |name|
    Project.create(name: name, description: Faker::Lorem.sentence(1))
end
15.times do |i|
 Member.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
end

SKILLS.each do |skill|
    Skill.create(name: skill)
end

20.times do |i|
    Task.create(description: Faker::Lorem.sentence(2), skill_id: Faker::Number.between(1,5), project_id: Faker::Number.between(1,4))
end

20.times do |i|
    MemberSkill.create(member_id: Faker::Number.between(1,15),skill_id: Faker::Number.between(1,5))
end