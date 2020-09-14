class User < ActiveRecord::Base
  include Slugable::InstanceMethods
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password
  def self.find_by_slug(slug)
    self.all.find do |instance|
     instance.slug == slug
    end
  end
end
