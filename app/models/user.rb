class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles
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
end
