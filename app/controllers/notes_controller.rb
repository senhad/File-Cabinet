class NotesController < ApplicationController 

  get '/notes' do 
  	@notes = current_user.notes.map { |note| note.content}
  	erb :'notes/index'
  end 

  get '/notes/new' do
	if logged_in?
		erb :'notes/new'
	else 
		redirect '/login'
	end
end 

post '/notes' do 
	@note = current_user.notes.build(content: params[:content])
	if @note.save 
		redirect "/notes"
	else 
		redirect '/notes/new'
	end 

end 



end 