class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :drinks, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_drinks, through: :likes, source: :drink

  has_many :comments, dependent: :destroy

  has_many :drinks, dependent: :destroy 
  validates :nickname, presence: true
  validates :profile, length: { maximum: 200 }

  mount_uploader :avatar, AvatarUploader
  
  def already_liked?(drink)
    self.likes.exists?(drink_id: drink.id)
  end

end