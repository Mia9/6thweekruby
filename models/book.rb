# put validate for user input
class Book < ActiveRecord::Base
	has_many :reviews  #-----to relate towards review class/model
	validates_presence_of :title
	validates_presence_of :author
end