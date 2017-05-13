require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "secret"
  end

  get '/' do
  	if !logged_in?
  		erb :index
  	else 
  		redirect '/notes'
  	end
  end 

  get '/signup' do
  	if !logged_in? 
  	 erb :'users/signup'
  	else 
  		redirect '/notes'
  	end 
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
  	if !logged_in?
    	erb :'users/login'	
    else 
    	redirect '/notes'  
    end 
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

    def authenticate_user
      if !logged_in?
        flash[:message] = "You are not logged in."
        redirect '/login'
      end
    end 
  end

end
