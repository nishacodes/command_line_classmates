require './lib/scraper.rb'
require './lib/student.rb' # requires all files in lib directory
require 'launchy'



	student_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

	names = student_scraper.get_student_names
	twitters = student_scraper.get_twitter
	blogs = student_scraper.get_blogs

	students =[]
	28.times do |i|
		students << Student.new(names[i],twitters[i],blogs[i])
	end


class GetStudent

	attr_reader :student

	def initialize
		@student
	end

	def run
		askInfo
		printInfo
	end

	def askInfo
		puts "Enter the name of the person you want to look up. Or enter 'all' to see everyone."
		@student = gets.chomp
	end

	def printInfo
		if @student == "all" 
			students.each do |student|
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







