class Listing < ApplicationRecord
  belongs_to :profile

  enum status: {
    deleted: 0,
    active: 1
  }

  enum category: {
    camera: 0,
    lens: 1,
    accessory: 2
  }

  validates :title, length: { minimum: 50 }
  validates :brand, presence: true
  validates :model, presence: true
  validates :description, length: { minimum: 100 }
  validates :rate, numericality: { greater_than: 0 }

  has_one_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  has_one_attached :image4
  has_one_attached :image5
end
