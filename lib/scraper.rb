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
	# NEED TO FIX THE 19 TO BE RESPONSIVE TO PPL W/OUT BLOGS
	def get_blogs
		blogs = []
    html.search("ul.social").each do |social_div|
      if social_div.search("a.blog").text == "Blog"
        blogs << social_div.search("a.blog")[0]["href"]
      else
        blogs << "none"
      end
    end
    blogs
	end

	# returns array of twitter handles
	def get_twitter
		mixed_array = html.search("li:first-child a").text.split(" ")
    twitter = []
    mixed_array.map do |name| 
      if name[0] == "@"
        twitter << name
      else
        twitter << "none"
      end
    end
    twitter
	end
	
end

my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
# puts my_scraper.get_student_names
p my_scraper.get_blogs
# puts my_scraper.get_twitter