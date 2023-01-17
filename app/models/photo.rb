class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :comments
  has_many :likes
  has_many :fans, through: :likes

  validates :caption, presence: true
  validates :image, presence: true
end
