require 'faker'
SKILLS = ["Javascript","Ruby","Ruby on Rails", "Sinatra", "HTML/CSS"]

5.times do |i|
    Project.create(name: Faker::Lorem.word, description: Faker::Lorem.sentence(1))
end
5.times do |i|
 Member.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
end

SKILLS.each do |skill|
    Skill.create(name: skill)
end

20.times do |i|
    Task.create(description: Faker::Lorem.sentence(2), skill_id: Faker::Number.between(1,5), project_id: Faker::Number.between(1,5))
end

10.times do |i|
    MemberSkill.create(member_id: Faker::Number.between(1,5),skill_id: Faker::Number.between(1,5))
end