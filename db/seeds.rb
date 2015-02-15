# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "jonathanclui", first_name: "Jonathan", last_name: "Lui", email: "lui.jonathanc@gmail.com", cell: "9095250616", address_line_one: "400 Clementina Street", address_line_two: "#309", city: "San Francisco", state: "CA", zipcode: "91765")

Route.create(start_long: "-122.4194155", start_lat: "37.7749295", end_long: "-122.393757", end_lat: "37.795313", distance: "2.2", price: "5.47")
