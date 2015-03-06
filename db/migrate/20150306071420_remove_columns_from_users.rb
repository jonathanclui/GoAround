class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :cell, :string
    remove_column :users, :address_line_one, :string
    remove_column :users, :address_line_two, :string
    remove_column :users, :state, :string
    remove_column :users, :zipcode, :string
    remove_column :users, :city, :string
  end
end
