class Route < ActiveRecord::Base
    belongs_to :user
    validates :start_long, presence: true
    validates :start_lat, presence: true
    validates :end_long, presence: true
    validates :end_lat, presence: true
    validates :distance, presence: true
    validates :price, presence: true
end
