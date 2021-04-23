class Post < ApplicationRecord

  belongs_to :user
  has_many :post_images
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :genre

  accepts_attachments_for :post_images, attachment: :image
  acts_as_taggable

  validates :title, presence: true
  validates :body, presence: true


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # def self.sort(selection)
  #   case selection
  #   when "new"
  #     return all.order(created_at: :DESC)
  #   when "old"
  #     return all.order(created_ad: :ASC)
  #   when "favorites"
  #     return find(Favorite.group(:post_id).order(Arel.sql("count(post_id) desc")).pluck(:post_id))
  #   end
  # end

end
