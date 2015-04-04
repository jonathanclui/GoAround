class RemovePasswordsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :reset_digest, :string
    remove_column :users, :reset_sent_at, :datetime
    remove_column :users, :string, :string
  end
end
