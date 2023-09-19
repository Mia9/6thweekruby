require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/book'
require_relative 'models/review'

get '/' do
	erb :index
end
#----------BOOK_PART------------
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

post '/books/reviews/:id' do
	@book = Book.find(params[:id])
	@book.reviews.create(name: params[:name], score: params[:score])
	erb :book
end