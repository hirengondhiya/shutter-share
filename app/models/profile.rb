class Profile < ApplicationRecord
  belongs_to :user

  # below validations are forced only on profile update
  validates :name, presence: true, on: :update
  validates :location, presence: true, on: :update
  # regular expression to check valid australian phone numbers
  # The regex does not match with empty string hence no need for presence validation
  validates :phone,
            format: {
              with: /\A\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}\z/,
              message: "Please enter a valid Australian mobile or landline number."
            }, on: :update

  has_one_attached :picture
  has_many :listings # created by the user
  has_many :lease_requests # sent by the user

  def lease_requests_received
    LeaseRequest.where(listing_id: self.listings.pluck(:id))
  end
end
