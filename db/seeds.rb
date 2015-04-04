# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: "Jonathan", last_name: "Liu", email: "test@gmail.com", password: "password", password_confirmation: "password", admin: true)

# User creation
50.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "example-#{n+1}@goaround.com"
    password = "password"
    User.create!(   first_name: first_name,
                    last_name: last_name,
                    email: email,
                    password: password,
                    password_confirmation: password)
end

# Travel Routes
users = User.order(:created_at).take(6)
50.times do
    start_long = Faker::Address.longitude
    start_lat = Faker::Address.latitude
    end_long = Faker::Address.longitude
    end_lat = Faker::Address.latitude
    distance = Faker::Commerce.price
    price = Faker::Commerce.price
    users.each { |user| user.travel_routes.create!(start_long: start_long, start_lat: start_lat, end_long: end_long, end_lat: end_lat, distance: distance, price: price, user_id: user.id) }
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
