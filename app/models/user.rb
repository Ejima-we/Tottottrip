class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :favorites

  validates :name, presence: true
  validates :nickname, presence: true

  def self.guest
    user = User.new(email: "#{SecureRandom.alphanumeric}@example.com", password: SecureRandom.urlsafe_base64, name: "guest5gbcyjsozzkdyyb6", nickname: "guest")
    user.save
    User.last
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
