require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password, :user_alert_stop, :user_alert_bus. :minute, :time
  attr_accessible :name, :email, :twitter, :password, :password_confirmation, :admin

	# this joins a query from the alert class to find alerts to be sent
	def self.alerts_to_be_sent(b, s, d, t)
    joins(:alerts) & Alert.alerter(b, s, d, t)
  end
	
	has_many :alerts, :dependent => :destroy

  # this will check if the username is present and make sure
  # the name length is not too long
  validates :name, :presence => true, :length => {:maximum => 50}

  # regex to validate email addresses
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # validates the email
  validates :email, :presence => true, :format => {:with => email_regex},
  :uniqueness => {:case_sensitive => false}

	# validates the presence of a user twitter
  validates :twitter, :presence => true, :uniqueness => {:case_sensitive => false}#, :twitter_user

  # consistency of the password entered
  validates :password, :presence     => true,
  :confirmation => true,
  :length       => { :within => 6..40 }

	# before the save encrypt the password
	# the method to encrypt is below
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

		# pay no attention to this
		def twitter_user
			twitter_client = TwitterClient.new
				errors.add(:twitter, t("Twitter username does not exit")) unless twitter_client.user_search :twitter
							
		end

		# encrypts the password
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
