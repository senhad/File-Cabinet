class NotesController < ApplicationController 

  get '/notes' do
  	if logged_in? 
	  	@notes = current_user.notes
	  	erb :'notes/index'
  	else 
		redirect '/login'
	end 
  end 

  get '/notes/new' do
	if logged_in?
		erb :'notes/new'
	else 
		redirect '/login'
	end
end 

post '/notes' do 
	@note = current_user.notes.build(title: params[:title], content: params[:content])
	if @note.save 
		redirect "/notes"
	else 
		redirect '/notes/new'
	end 

end 

get '/notes/:id' do 
	if logged_in?
		@note = Note.find_by_id(params[:id])
		erb :'notes/show'
	else 
		redirect '/login'
	end 
end 

get '/notes/:id/edit' do 
	if logged_in?
		@note = Note.find_by_id(params[:id])
		erb :'notes/edit'
	else 
		redirect '/login'
	end 
end 



end 