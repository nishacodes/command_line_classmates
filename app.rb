require './lib/scraper.rb'
require './lib/student.rb' # requires all files in lib directory
require 'launchy'


class GetStudent

	attr_accessor :names, :twitters, :blogs, :students, :request

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
		formatLinks
		showOptions
		askInfo
		processRequest
	end

	def storeInfo
		28.times do |i|
			@students << Student.new(@names[i],@twitters[i],@blogs[i])
		end
	end

	def formatLinks
		@twitters.delete("none")
		@twitters.each {|handle| handle.gsub!("@","http://www.twitter.com/") }
		@blogs.delete("none")
	end

	def showOptions
		puts "-" * 60
		puts "************ FLATIRON SCHOOL STUDENT DIRECTORY ************"
		puts "Please choose from the below options:"
		puts "-" * 60
		puts "'[name] -b'   to launch that student's blog"
		puts "'[name] -t'   to launch that student's twitter"
		puts "'any -b'      to launch a random student's blog"
		puts "'any -t'      to launch a random student's twitter"
		puts "'all'         to view all student info"
		puts "-" * 60
	end
	
	def askInfo
		puts "Please enter your choice."
		@request = gets.chomp
	end

	def processRequest
		if @request.start_with?('any')
			launchRandom
		elsif @request == "all"
			puts "printinfo"
			# printInfo
		elsif @request.end_with?('-b') || @request.end_with?('-t')
			puts "byname"
			# launchByName
		else
			puts "Sorry that is not a valid option. Try again."
			@request = gets.chomp
			processRequest
		end
	end

	def launchByName
		puts "hi"
		# case
		# 	when @request == "any -t"
				
		# 	when @request == "any -b"
				
		# 	end
	end

	def launchRandom
		case
			when @request == "any -b"
				Launchy.open("#{@blogs.sample}")
			when @request == "any -t"
				Launchy.open("#{@twitters.sample}")
			end
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







