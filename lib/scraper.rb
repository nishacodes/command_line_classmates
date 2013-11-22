require 'open-uri' # part of the ruby package; need it to open urls
require 'nokogiri' 

class Scraper
	attr_reader :html
	
	def initialize (url)
		download = open(url)
		@html = Nokogiri::HTML(download)  # class::class_method(parameter)
	end
	
	# returns array of student names
	def get_student_names	
		students = html.search("h3").collect do |h3|
			h3.text
		end
		# ALTERNATE METHOD USING REGEX: ?<= is look behind and ?= is look ahead. it splits in between these
		# students = html.search("h3").text.split(/(?<=[a-z.])(?=[A-Z])/) 
	end

	# returns array of blog urls
	def get_blogs
    blogs = html.search(".back").map do |back_div|
      if back_div.search(".blog").text == "Blog"
        back_div.search(".blog")[0]["href"]
      else
        "none"
      end
    end
	end

	# returns array of twitter names
	def get_twitter
    twitter = html.search(".back").map do |back_div|
      if back_div.search(".twitter").text.nil?
        "none"
      else
        back_div.search(".twitter").text.strip
      end
    end
	end

end
