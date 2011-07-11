class Admin < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  # built in authentication
  # has_secure_password

  attr_accessor :password
  before_save :prepare_password

  has_many :posts
  # has_many :draft_posts
  # has_many :published_posts

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_associated :posts

  # login can be either username or email address
  # nifty authentcation
  def self.authenticate(login, pass)
    admin = find_by_username(login) || find_by_email(login)
    return admin if admin && admin.password_hash == admin.encrypt_password(pass)
  end

  # nifty authentcation
  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  # nifty authentcation
  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end

# == Schema Information
#
# Table name: admins
#
#  id            :integer         not null, primary key
#  username      :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

