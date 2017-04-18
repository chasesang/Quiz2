# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#create users
20.times do
  User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '123',
                password_confirmation: '123'
    )
    puts "User created!"
  end


# create ideas
20.times do
  user = User.all.sample

  Idea.create({ title: Faker::Friends.character,
  body: Faker::Lorem.paragraph,
  user_id: user.id
    })
  end

# create reviews
ideas = Idea.all

ideas.each do |idea|
  rand(2..10).times do
    user = User.all.sample
    idea.reviews.create({
      body: Faker::Friends.quote,
      user_id: user.id
      })
  end
end

ideas_count = Idea.count
reviews_count = Review.count


puts Cowsay.say "Created #{ideas_count}", :cow
puts Cowsay.say "Created #{reviews_count}", :cow
