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
    html.search(".back").each do |back_div|
      if back_div.search(".social .blog").text == "Blog"
        blogs << back_div.search(".social .blog")[0]["href"]
      else
        blogs << "none"
      end
    end
    blogs
	end

	def get_twitter
		twitter = []
    html.search(".back").each do |back_div|
      if back_div.search(".social .twitter").text[0] == "@"
        twitter << back_div.search(".social .twitter").text
      else
        twitter << "none"
      end
    end
    twitter
	end


	
end
