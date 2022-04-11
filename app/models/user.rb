class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :profile, dependent: :destroy
  
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  
  
  
  
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
  
   def has_liked?(user)
    likes.exists?(user_id: user.id)
  end
  
  def follow!(user)
    user_id = get_user_id(user)
    
    following_relationships.create!(following_id: user_id)
  end
  
  def unfollow!(user)
    user_id = get_user_id(user)
    
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end
  
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end
  
   private
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end
end
