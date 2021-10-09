class Drink < ApplicationRecord

    belongs_to :user

    mount_uploader :image, ImageUploader

    validates :image, presence: { message: "画像を選択してください" }

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy

    has_one_attached :image

end
