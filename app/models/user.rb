class User < ActiveRecord::Base
  attr_accessible :name, :email, :twitter
  
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
end
