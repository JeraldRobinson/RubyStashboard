# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  has_many :services, dependent: :destroy
  
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :name, :email
  validates :email, format: { with: valid_email_regex }, uniqueness: { case_sensitive: false }
  validates_length_of :name, :maximum => 50
  validates_length_of :email, :maximum => 30
  validates :password, length: { minimum: 6 }
  
  def feed
    Service.where("user_id = ?", self.id)
  end
  
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  

end
