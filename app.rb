require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require_relative 'models/book'
require_relative 'models/review'
require_relative 'models/user'
enable :sessions

get '/' do
	erb :index
end
#----------BOOK_PART------------

get '/add_book' do
	erb :add_book
end

post '/add-book' do
	@book = Book.create(title: params[:title], author: params[:author])
	if @book.save
		erb :book
	else
		#redirect '/' #---or erb :index
		erb :index
	end
end

get '/books' do #-----books erb
	@books = Book.all
	erb :books
end

get '/books/:id' do #-----books erb (Details)
	@book = Book.find(params[:id])
	erb :book
end

post '/books/edit/:id' do #-----book erb
	@book = Book.find(params[:id])
	erb :edit_book
end

post '/books/update/:id' do #-----edit_book erb
	@book = Book.find(params[:id])
	@book.update(title: params[:title], author: params[:author])
	erb :book
end

post '/books/delete/:id' do #-----book erb
	@book = Book.find(params[:id])
	if @book
		@book.destroy
		redirect '/books'
	else
		redirect '/'
	end
end

#------------REVIEW PART-----------------

post '/books/review/:id' do
	@book = Book.find(params[:id])
	erb :review
end

post '/books/add_review/:id' do
	@book = Book.find(params[:id])
	@book.reviews.create(name: params[:name], score: params[:score])
	erb :book
end

# def display_review(book_id) #----testing to see at console before html
# 	show_review = Review.find_by(book_id)
# 	puts show_review
# 	puts show_review.class
# 	puts show_review.name
# 	puts show_review.score
# end
# display_review(book_id: 7)

#---------PASSWORD PART---------

get '/register' do
	erb :register
end

post '/register' do
	@user = User.create(username: params[:username],
						password: params[:password] )
	if @user.save
		redirect '/login'
	else
		redirect '/register'
	end
end

get '/login' do
	erb :login
end

post '/login' do
	@user = User.find_by(username: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/add_book'
	else
		erb :login
	end
end

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end