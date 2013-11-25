require './lib/scraper.rb'
require './lib/student.rb' # requires all files in lib directory
require 'launchy'


class Directory
	attr_accessor :names, :twitters, :blogs, :students, :request, :student, :index

	def initialize
		scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
		@names = scraper.get_student_names
		@twitters = scraper.get_twitter
		@blogs = scraper.get_blogs
		@students = []
		@request
		@student
		@index
	end

	def run
		storeInfo
		formatLinks
		showOptions
		askInfo
	end

	def storeInfo
		28.times do |i|
			@students << Student.new(@names[i],@twitters[i],@blogs[i])
		end
	end

	def formatLinks
		@twitters.each {|handle| handle.gsub!("@","http://www.twitter.com/") }
	end

	def removeNone
		@twitters.delete("none")
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
		puts "'end'         to exit the program"
		puts "-" * 60
	end
	
	def askInfo
		puts "What would you like to see?"
		@request = gets.chomp
		processRequest
	end

	def processRequest
		if @request.start_with?('any')
			launchRandom
		elsif @request == "all"
			printInfo
		elsif @request.end_with?('-b') || @request.end_with?('-t')
			findStudent
		elsif @request == "end"
			exit
		else
			puts "Sorry that is not a valid option. Try again."
			@request = gets.chomp
			processRequest
		end
	end

	def findStudent
		request_array = @request.downcase.split(" ")
		first_name = request_array[0]
		@request = request_array.last

		@names.each_with_index do |name, index|
			if name.downcase.split(" ")[0] == first_name
				@index = index
			end
		end

		if @index.nil? 
			puts "Sorry, that student does not exist."
			askInfo
		else
			launchByName
		end
	end

	def launchByName
		case 
			when @request == "-b"
				if @blogs[@index] == "none" 
					puts "Student does not have a blog." 
				else
					link = @blogs[@index]
					Launchy.open("#{link}")
				end
			when @request =="-t"
				if @twitters[@index] == "none"
					puts "Student does not have a Twitter account. " 
				else
					link = @twitters[@index]
					Launchy.open("#{link}")
				end
			end
		askInfo	
	end

	def launchRandom
		removeNone
		case
			when @request == "any -b"
				Launchy.open("#{@blogs.sample}")
			when @request == "any -t"	
				Launchy.open("#{@twitters.sample}")
			end
		askInfo
	end
	
	def printInfo
		puts "*" * 60
		@students.each do |student|
			puts student.name
			puts "Twitter: #{student.twitter}"
			puts "Blog: #{student.blog}"
			puts "*" * 60
		end
		askInfo
	end

	def exit
		puts "Have a nice day."
	end

end


directory = Directory.new
directory.run







