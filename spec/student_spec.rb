require "../lib/student"

describe Student, "#name" do

	it "should return the name of the student" do
		expect(Student.new("Nisha Batra").name).to eq("Nisha Batra")
	end

end

describe Student, "#twitter" do

	it "should return the twitter handle of the student" do
		expect(Student.new("","@nishacodes").twitter).to eq("@nishacodes")
	end

end

describe Student, "#blog" do

	it "should return the blog of the student" do
		expect(Student.new("","","http://nishacodes.tumblr.com").blog).to eq("http://nishacodes.tumblr.com")
	end

end