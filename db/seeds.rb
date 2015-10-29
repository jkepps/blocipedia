include Faker

# Create Users
5.times do 
	User.create!(
		username: Internet.user_name, 
		email: Internet.email, 
		password: Internet.password
	)
end
users = User.all

# Create my user account
User.create!(
	username: "jepps",
	email: "member@example.com",
	password: "password"
)

# Create Wikis
30.times do
	body = Hacker.say_something_smart
	rand(3..6).times do
		paragraph = ""
		rand(10..30).times do
			paragraph += Hacker.say_something_smart
		end
		body += "\n #{paragraph}"
	end
	Wiki.create!(
		title: Book.title,
		body: body,
		user: users.sample,
		private: [true, false, false, false].sample
	)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"