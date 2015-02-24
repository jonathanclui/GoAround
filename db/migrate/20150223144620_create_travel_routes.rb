class CreateTravelRoutes < ActiveRecord::Migration
  def change
    create_table :travel_routes do |t|
      t.decimal :start_lat
      t.decimal :end_lat
      t.decimal :start_long
      t.decimal :end_long
      t.decimal :distance
      t.decimal :price
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :travel_routes, :users
    add_index :travel_routes, [:user_id, :created_at]
  end
end
