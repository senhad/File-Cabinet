require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
  		erb :index
  end 

  get '/signup' do 
  		erb :'users/signup'
  end 

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
    	session[:id] = @user.id
    	redirect '/notes'    #here can also put to redirect to login
    else 
		redirect '/signup'
	end 
  end

  get '/login' do
    	erb :'users/login'	
  end

  post '/login' do
    user = User.find_by(username: params[:username])
	if user && user.authenticate(params[:password])
		session[:id] = user.id 
		redirect '/notes'
	else 
		redirect '/login'
	end 
  end


  get '/notes' do 
  	erb :'notes/index'
  end 

  get '/logout' do 
	    session.clear
	    redirect '/login'
  end


  helpers do 

	def logged_in?
	  !!current_user
	end

	def current_user
	  @current_user ||= User.find(session[:id]) if session[:id]
	end 

end 



end
