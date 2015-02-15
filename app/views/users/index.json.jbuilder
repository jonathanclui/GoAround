json.array!(@users) do |user|
  json.extract! user, :id, :username, :first_name, :last_name, :e-mail, :cell, :address_line_one, :address_line_two, :city, :state, :zipcode
  json.url user_url(user, format: :json)
end
