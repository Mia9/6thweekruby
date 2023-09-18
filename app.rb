require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/book'


get '/' do
	erb :index
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

get '/books' do
	@books = Book.all
	erb :books
end