class AddTokenImagePromoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refresh_token, :string
    add_column :users, :picture, :string
    add_column :users, :promo_code, :string
  end
end
