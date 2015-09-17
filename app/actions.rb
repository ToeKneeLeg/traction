# Homepage (Root path)
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

post '/member/:id' do
  @team_member = Member.find(params[:id])
  @skill_exist = Skill.where(name: params[:skill])
  if !@skill_exist.empty?
    @member_skill = MemberSkill.create(
      member_id: @team_member.id,
      skill_id: Skill.find_by_name(params[:skill]).id
    )
  else
    Skill.create(name: params[:skill])
    @member_skill = MemberSkill.create(
      member_id: @team_member.id,
      skill_id: Skill.find_by_name(params[:skill]).id
    )
  end
  redirect "/member/#{@team_member.id}"
end

get '/member/:id' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  end
  @team_member = Member.find(params[:id])
  @skills = @team_member.member_skills.all
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

get "/dashboard/:id" do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  else
    redirect '/register'
  end
  @project = Project.find(params[:id])
  erb :'/dashboard/show'
end

post '/dashboard-project' do
  @project = Project.new(
    name: params[:name],
    description: params[:description]
    )
  if @project.save
    redirect "/dashboard/#{@project.id}"
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

get '/dashboard' do
  @project = Project.first
  @tasks = Task.all
  @unassigned = Task.where(member_id: nil)
  erb :'dashboard/show'
end
