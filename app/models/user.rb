class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      # ゲスト情報を指定
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "ゲスト"
    end
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
