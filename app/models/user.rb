require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :twitter, :password, :password_confirmation

  # this will check if the username is present and make sure
  # the name length is not too long
  validates :name, :presence => true, :length => {:maximum => 50}

  # regex to validate email addresses
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # validates the email
  validates :email, :presence => true, :format => {:with => email_regex},
  :uniqueness => {:case_sensitive => false}

  # :TODO I will have to validate users twitter id
  validates :twitter, :presence => true

  # consistency of the password entered
  validates :password, :presence     => true,
  :confirmation => true,
  :length       => { :within => 6..40 }

  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

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
