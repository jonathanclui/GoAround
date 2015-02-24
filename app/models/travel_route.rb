class TravelRoute < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :start_lat, presence: true
  validates :end_lat, presence: true
  validates :start_long, presence: true
  validates :end_long, presence: true
  validates :distance, presence: true
  validates :price, presence: true

end
