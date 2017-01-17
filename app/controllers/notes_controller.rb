class NotesController < ApplicationController 

  get '/notes' do 
  	@notes = current_user.notes.map { |note| note.content}
  	erb :'notes/index'
  end 



end 