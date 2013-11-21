require './lib/scraper.rb'
require './lib/student.rb' # requires all files in lib directory

# 1) make a new scraper
# 2) get student names from scraper
# 3) get the blogs
# 4) get the twitter
# 5) make a new student object for each one

student_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

names = student_scraper.get_student_names
twitters = student_scraper.get_twitter
blogs = student_scraper.get_blogs

students =[]
28.times do |i|
	students << Student.new(names[i],twitters[i],blogs[i])
end

students.each do |student|
	puts student.name
	puts student.twitter
	puts student.blog
end

