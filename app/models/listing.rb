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
end
