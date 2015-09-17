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

post '/dashboard' do
  @project = Project.new(
    name: params[:name],
    description: params[:description]
    )
  if @project.save
    redirect "/dashboard/#{@project.id}"
  end
end

get '/log_out' do
  session.delete(:member_id)
  redirect '/'
end