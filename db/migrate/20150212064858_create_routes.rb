class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.decimal :start_long
      t.decimal :start_lat
      t.decimal :end_long
      t.decimal :end_lat
      t.decimal :distance
      t.decimal :price

      t.timestamps null: false
    end
  end
end
