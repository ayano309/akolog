class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :profile, dependent: :destroy
  
  delegate :birthday, :gender, to: :profile, allow_nil: true
  
  def has_written?(article)
    articles.exists?(id: article.id)
  end
  
  def display_name
    profile&.nickname || self.email.split('@').first
  end

  def birthday
    profile&.birthday
  end

  def gender
    profile&.gender
  end
  
   def has_liked?(article)
    likes.exists?(article_id: article.id)
  end
end
