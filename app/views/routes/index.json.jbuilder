json.array!(@routes) do |route|
  json.extract! route, :id, :start_long, :start_lat, :end_long, :end_lat, :distance, :price
  json.url route_url(route, format: :json)
end
