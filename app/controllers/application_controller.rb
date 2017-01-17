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

  get '/login' do
    	erb :'users/login'	
  end




end
