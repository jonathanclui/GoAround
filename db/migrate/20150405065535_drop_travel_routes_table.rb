class DropTravelRoutesTable < ActiveRecord::Migration
  def change
    drop_table :travel_routes
  end
end
