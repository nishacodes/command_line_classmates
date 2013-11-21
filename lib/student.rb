class Student
	attr_reader :name, :twitter, :blog

	def initialize(name="",twitter="",blog="")
		@name = name
		@twitter = twitter
		@blog = blog
	end

end

