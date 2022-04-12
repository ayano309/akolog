class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :title, presence: true
  validates :content, presence: true

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
  
  def has_liked?(user)
    likes.exists?(user_id: user.id)
  end
  
  
end
