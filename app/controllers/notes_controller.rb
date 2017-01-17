class NotesController < ApplicationController 

  get '/notes' do 
  	erb :'notes/index'
  end 



end 