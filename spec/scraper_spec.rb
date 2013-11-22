require "../lib/scraper"

student_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

describe Scraper, "#get_student_names" do

	it "should return 28 student names" do
		expect(student_scraper.get_student_names.length).to eq(28)
	end

	it "should include names of students" do
		expect(student_scraper.get_student_names).to include("Nisha Batra")
	end

end

describe Scraper, "#get_blogs" do
	#failing - a couple empty slots
	it "should return 28 items total" do
		expect(student_scraper.get_blogs.length).to eq(28)
	end

	it "should include the blog URLs" do
		expect(student_scraper.get_blogs).to include("http://nishacodes.tumblr.com")
	end

end

describe Scraper, "#get_twitter" do

	#failing - a couple empty slots
	it "should return 28 items total" do
		expect(student_scraper.get_twitter.length).to eq(28)
	end

	it "should include the twitter handles of students" do
		expect(student_scraper.get_twitter).to include("@nishacodes")
	end

end