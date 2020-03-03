class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :location, presence: true
  validates :phone,
            format: {
              with: /\A\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}\z/,
              message: "Please enter a valid Australian mobile or landline number."
            }
end
