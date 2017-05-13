class NotesController < ApplicationController 

	get '/notes' do
  		authenticate_user
  		@notes = current_user.notes
  		erb :'notes/index'
  	end 

  	get '/notes/new' do
		authenticate_user
		erb :'notes/new'
  	end 

	post '/notes' do 
		@note = current_user.notes.build(title: params[:title], content: params[:content])
		if @note.save 
			flash[:message] = "You successfully created a new note!"
			redirect "/notes"
		else 
			redirect '/notes/new'
		end 
	end 

	get '/notes/:id' do 
		authenticate_user
		@note = Note.find_by_id(params[:id])
		if @note && current_user == @note.user
			erb :'notes/edit'
		else
			flash[:message] = "This is not your note."
			redirect '/notes'
		end
	end 

	get '/notes/:id/edit' do 
		authenticate_user
		@note = Note.find_by_id(params[:id])
		if @note && current_user == @note.user
			erb :'notes/edit'
		else
			flash[:message] = "This is not your note."
			redirect '/notes'
		end 
	end 

	patch '/notes/:id' do 
		authenticate_user
		@note = Note.find_by_id(params[:id])
		if @note && current_user == @note.user
			if @note.update(title: params[:title], content: params[:content])
				flash[:message] = "You note is edited."
				redirect "/notes/#{@note.id}"
			else
				flash[:message] = "Your note did not update."
				redirect "/notes/#{@note.id}/edit"
			end
		else
			flash[:message] = "This is not your note."
			redirect '/notes'
		end 
	end 


	delete '/notes/:id/delete' do
		authenticate_user
		@note = current_user.notes.find_by_id(params[:id])
		@note.delete
		flash[:message] = "You successfully deleted the note."
		redirect to '/notes'
	end 

end 