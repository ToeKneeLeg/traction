# # Homepage (Root path)
get '/' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  end
  erb :index
end

post '/' do
  if @member = Member.find_by_email(params[:email])
    session[:member_id] = @member.id
    redirect '/dashboard'
  else
    redirect '/register'
  end
end

get '/register' do
  if session[:member_id]
    redirect '/dashboard'
  end
  erb :register
end

post '/register' do
  @member = Member.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    )
  @project = Project.new(
    name: params[:name],
    description: params[:description]
    )
  if @member.save && @project.save
    session[:member_id] = @member.id
    redirect '/dashboard'
  else
    erb :register
  end
end

post '/member/:id/delete' do
  @member = Member.find(params[:memberid])
    @member.destroy
    redirect '/dashboard'
end

post '/member/:id' do
  @team_member = Member.find(params[:member_id])
  @find_skill = Skill.find_by_name(params[:skill])
  if @find_skill.nil?
    @new_skill_from_member = Skill.create(name: params[:skill])
    MemberSkill.create(member_id: @team_member.id, skill_id: @new_skill_from_member.id)
  else
    MemberSkill.create(member_id: @team_member.id, skill_id: @find_skill.id)
  end
  redirect "/member/#{@team_member.id}"
end

get '/member/:id' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  end
  @team_member = Member.find(params[:id])
  @tasks = @team_member.tasks
  @skills = @team_member.skills
  @all_skills = Skill.all
  erb :'/member/show'
end

get '/dashboard' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  else
    redirect '/register'
  end
  @team_members = Member.all
  @projects = Project.all
  erb :'dashboard/index'
end

post '/dashboard-project' do
  @project = Project.new(
    name: params[:name],
    description: params[:description]
    )
  if @project.save
    redirect "/dashboard/project/#{@project.id}"
  end
end

post '/dashboard-member' do
  @member = Member.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email]
  )
  if @member.save
    redirect "/member/#{@member.id}"
  end
end

get '/log_out' do
  session.delete(:member_id)
  redirect '/'
end

get '/dashboard/project/:id' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  else
    redirect '/register'
  end
  @project = Project.find params[:id]
  @tasks = @project.tasks
  @skills = Skill.all
  @unassigned = @project.tasks.where(member_id: nil,
                                    completed: false)
  erb :'dashboard/show'
end

post '/dashboard/project/:id/assign' do
  @project = Project.find(params[:projectid])
  @all_members = Member.all
  @available_member = []

  @all_members.each do |member|
    if member.tasks.length <= 2
      @available_member << member
    end
  end

  if @available_member
    @task_available_for_assignment = Task.where(project_id: @project.id, completed: false, member_id: nil)

    @task_to_assign = nil

    @ideal_member = @available_member.find do |member|

      @task_to_assign = @task_available_for_assignment.find do |t|
        member.skills.exists?(t.skill_id)
      end
    end
  end
   if  @task_to_assign
    @task_to_assign.member = @ideal_member

    @task_to_assign.save
   end
  redirect "dashboard/project/#{params[:projectid]}"
end

#to update completed tasks
#cannot use put in form so we use post to another end point
post '/dashboard/project/:id/update' do
  @project = Project.find(params[:projectid])
  @task = Task.find(params[:task_completed])
  @task.update(completed: true,
               member_id: nil)

  redirect "dashboard/project/#{params[:projectid]}"
end

  post '/dashboard/project/:id/delete' do
    @project = Project.find(params[:projectid])
    @project.delete
    redirect '/dashboard'
  end

#to add a new task
post '/dashboard/project/:id' do
  @project = Project.find(params[:projectid])
  @tasks = @project.tasks
  @member = Member.find(session[:member_id])
  @unassigned = @project.tasks.where(member_id: nil)
  @skill_id = Skill.find_by_name(params[:required_skill])
  if !@skill_id.nil?
    @new_task = Task.create(project_id: params[:projectid],
                            description: params[:description],
                            required_skill: params[:required_skill],
                            skill_id: @skill_id.id
                            )
    @new_task.save
    redirect "dashboard/project/#{params[:projectid]}"
  else
    @new_skill = Skill.create(name: params[:required_skill])
    @new_task = Task.create(project_id: params[:projectid],
                            description: params[:description],
                            required_skill: params[:required_skill],
                            skill_id: @new_skill.id
                            )
    @new_task.save
    redirect "dashboard/project/#{params[:projectid]}"
  end
end
