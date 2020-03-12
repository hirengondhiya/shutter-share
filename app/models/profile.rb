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

  # returns true if the current profile sent at least one lease request for a given listing
  def lease_request_sent_for_listing? listing_id
    self.lease_requests.find_by(listing_id: listing_id) != nil
  end

  # returns an array of lease_requests sent by current profile for a given listing
  def lease_requests_sent_for_listing listing_id
    self.lease_requests.where(listing_id: listing_id)
  end

  # returns an array of lease_requests received on all listings
  def lease_requests_received
    LeaseRequest.where(listing_id: self.listings.pluck(:id))
  end

  # returns an array of lease_requests where current profile is either requester or listing owner
  def transactions
    LeaseRequest.where(profile_id: self.id).or(LeaseRequest.where(listing_id: self.listings.pluck(:id))).accepted.order(created_at: :desc)
  end
end
