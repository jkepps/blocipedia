include Faker

# Create Users
5.times do 
	User.create!(
		username: Internet.user_name, 
		email: Internet.email, 
		password: Internet.password
	)
end

# Create standard account
User.create!(
	username: "Standard_User",
	email: "standard@example.com",
	password: "password",
	role: "standard"
)

# Create premium account
User.create!(
	username: "Premium_User",
	email: "premium@example.com",
	password: "password",
	role: "premium"
)

# Create admin account
User.create!(
	username: "Admin_User",
	email: "admin@example.com",
	password: "password",
	role: "admin"
)
users = User.all

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
		private: [true, true, false, false].sample
	)
end
wikis = Wiki.all

# Create collaborators
20.times do
	collaborator = wikis.where(private: true).sample.collaborators.build(
		user: users.sample
	)
	collaborator.save
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaborator.count} collaborators created"