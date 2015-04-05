class User < ActiveRecord::Base
    attr_accessor :remember_token 

    before_save :downcase_email
    
    # Constants
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

    # Validations
    validates :provider, presence: true
    validates :uid, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :picture, presence: true
    validates :promo_code, presence: true, uniqueness: { case_sensitive: true }
    validates :oauth_token, presence: true, uniqueness: { case_sensitive: false }
    validates :refresh_token, presence: true, uniqueness: { case_sensitive: false }


    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.email = auth.info.email
            user.first_name = auth.info.first_name
            user.last_name = auth.info.last_name
            user.picture = auth.info.picture
            user.promo_code = auth.info.promo_code
            user.oauth_token = auth.credentials.token
            user.refresh_token = auth.credentials.refresh_token
            user.save!
        end
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Returns a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    private
    
        # Converts email to all lower-case.
        def downcase_email
            self.email = email.downcase
        end
end
