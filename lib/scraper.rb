require 'open-uri' # part of the ruby package; need it to open urls
require 'nokogiri' 

class Scraper
	attr_reader :html
	
	def initialize (url)
		download = open(url)
		@html = Nokogiri::HTML(download)  # class::class_method(parameter)
	end
	
	# html is a method here that returns @html (bc its in attr_reader)
	# .text gets the text inside of the tags
	def get_student_names	
		students = html.search("div.face.front h3").text 
	end

	# inside the href attribute
	def get_student_blogs
		blog_url = []
		19.times do |i|
			blog_url << html.search("a.blog[href]")[i]["href"]
		end
		blog_url
	end

	# only need to get the twitter name since twitter urls have the same pattern
	def get_twitter_urls
		mixed_array = html.search("li:first-child a").text.split(" ")
		twitter_array = mixed_array.select { |name| name[0] == "@"}
	end
end

my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
puts @html
puts my_scraper.get_student_blogs