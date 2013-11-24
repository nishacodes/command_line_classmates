require './lib/scraper.rb'
require './lib/student.rb' # requires all files in lib directory
require 'launchy'


class GetStudent

	attr_accessor :scraper, :names, :twitters, :blogs, :students, :request

	def initialize
		scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
		@names = scraper.get_student_names
		@twitters = scraper.get_twitter
		@blogs = scraper.get_blogs
		@students = []
		@request
	end

	def run
		storeInfo
		askInfo
		printInfo
	end

	def storeInfo
		28.times do |i|
			@students << Student.new(@names[i],@twitters[i],@blogs[i])
		end
	end

	

	def askInfo
		puts "Enter the name of the person you want to look up. Or enter 'all' to see everyone."
		@request = gets.chomp
	end

	def printInfo
		if @request == "all" 
			@students.each do |student|
				puts student.name
				puts student.twitter
				puts student.blog
				puts "***********"
			end
		end

	end



end




app = GetStudent.new
app.run







