# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: "Jodie", last_name: "Thomas", email: "test@gmail.com",cell: "9172125678", address_line_one: "77 Massachusetts Avenue", address_line_two: "", city: "Cambridge", state: "MA", zipcode: "02139", password: "password", password_confirmation: "password", admin: true, activated: true, activated_at: Time.zone.now)

99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "example-#{n+1}@goaround.com"
    address_line_one = Faker::Address.street_address 
    state = Faker::Address.state
    city = Faker::Address.city
    zipcode = Faker::Address.zip_code
    cell = Faker::Number.number(10) 
    password = "password"
    User.create!(   first_name: first_name,
                    last_name: last_name,
                    email: email,
                    address_line_one: address_line_one,
                    state: state,
                    city: city,
                    zipcode: zipcode,
                    cell: cell,
                    password: password,
                    password_confirmation: password,
                    activated: true,
                    activated_at: Time.zone.now)
end
                    

Route.create(start_long: "-122.4194155", start_lat: "37.7749295", end_long: "-122.393757", end_lat: "37.795313", distance: "2.2", price: "5.47")
