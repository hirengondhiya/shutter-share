class LeaseRequest < ApplicationRecord
  belongs_to :profile
  belongs_to :listing

  enum status: {
    pending: 0,
    cancelled: 1,
    accepted: 2,
    rejected: 3,
    expired: 4
  }

  validates :start_date, :end_date, presence: true
  validate :start_date_after_today
  validate :end_date_after_start_date

  before_save :calculate

  def pending?
    self.status == "pending"
  end

  private
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
  def start_date_after_today
    return if start_date.blank?

    if start_date < Date.today
      errors.add(:start_date, "must be a future date")
    end
  end
  def calculate
    if self.valid?
      self.duration = (self.end_date - self.start_date).to_i / 86400
      self.rate = self.listing.rate
      self.total = self.duration * self.rate
    end
  end
end
