require 'open-uri' # part of the ruby package; need it to open urls
require 'nokogiri' 

class Scraper
	attr_reader :html
	
	def initialize (url)
		download = open(url)
		@html = Nokogiri::HTML(download)  # class::class_method(parameter)
	end
	
	# html is a method here that returns @html (bc its in attr_reader)
	# returns array of student names
	def get_student_names	
		students = html.search("div.face.front h3").text.split(/(?<=[a-z.])(?=[A-Z])/) # ?<= is look behind and ?= is look ahead. it splits in between these
		students
	end

	# returns array of blogs
	def get_blogs
		blogs = []
		19.times do |i|
			blogs << html.search("a.blog")[i]["href"]
		end
		blogs
	end

	# returns array of twitter handles
	def get_twitter
		mixed_array = html.search("li:first-child a").text.split(" ")
		twitter = mixed_array.select { |name| name[0] == "@"}
	end
	twitter
end

my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
puts my_scraper.get_student_names
puts my_scraper.get_blogs
puts my_scraper.get_twitter