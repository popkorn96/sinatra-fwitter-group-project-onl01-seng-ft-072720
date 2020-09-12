class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password
  def self.current_user(session)
    User.find(session[:user_id])
  end
  def self.is_logged_in?(session)
    session[:user_id] ? true : false    
  end
end
