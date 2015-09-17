# # Homepage (Root path)
get '/' do
  @member = Member.new
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

get '/dashboard' do
  if session[:member_id]
    @member = Member.find(session[:member_id])
  else
    redirect '/register'
  end
  @projects = Project.all
  erb :'dashboard/index'
end

get '/log_out' do
  session.delete(:member_id)
  redirect '/'
end

get '/dashboard/:id' do
  @member = Member.find(session[:member_id])
  @project = Project.find params[:id]
  @tasks = @project.tasks
  @unassigned = @project.tasks.where(member_id: nil)
  erb :'dashboard/show'
end

post '/dashboard/:id' do
  @project = Project.find(params[:projectid])
  @tasks = @project.tasks
  @member = Member.find(session[:member_id])
  @unassigned = @project.tasks.where(member_id: nil)
  @new_task = Task.create!(project_id: params[:projectid],
                          # member_id: @member.id,
                          description: params[:description],
                          required_skill: params[:required_skill]
                          )

  redirect "dashboard/#{params[:projectid]}"
end
