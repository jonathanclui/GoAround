class User < ActiveRecord::Base

    has_many :routes
    has_secure_password
    before_save { self.email = email.downcase }
    
    # Constants
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

    # Validations
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
    validates :password, length: { minimum: 6 }
    validates :password_confirmation, length: { minimum: 6 }
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :cell, presence: true, length: { maximum: 10 }
    validates :address_line_one, presence: true, length: { maximum: 255 }
    validates :city, presence: true, length: { maximum: 255 }
    validates :state, presence: true, length: { maximum: 255 }
    validates :zipcode, presence: true, length: { maximum: 10 }

end
