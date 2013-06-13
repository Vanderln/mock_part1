get '/' do
  # render home page
  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end

get '/user/:user_id/edit' do
  # p params[:user_id]
  user = User.find(current_user.id)
  
  erb :edit_skills, :locals => {:trueuser => params[:user_id] }
end

post '/edit_skill/:skill_id' do
  skill = Skill.find_by_id(params[:skill_id])
  skill.update_attributes(:name => params[:post][:name], :context => params[:post][:context])
  skill.proficiencies.first.update_attributes(:formal => params[:post][:formal], :years => params[:post][:years])
  redirect '/'
end

post '/new_skill' do
  # p params.inspect
  skill = Skill.create(:name => params[:post][:name], :context => params[:post][:context])
  # prof = Proficiency.create(:formal => params[:post][:formal], :years => params[:post][:years])
  # skill.proficiencies << prof
  p "made it"
  # redirect '/'
end



