class Booking < ApplicationRecord
  has_many :refunds
  belongs_to :customer
  belongs_to :workshop
  validates :order_number, presence: true, uniqueness: true

  after_create :update_workshop_seat_count
  before_validation :generate_order_number

  def update_workshop_seat_count
    workshop.update(remaining_seats: workshop.total_seats.to_i - no_of_tickets.to_i)
  end
  
  def generate_order_number
    self.order_number = "Booking-#{SecureRandom.hex(5).upcase}"
  end

  def is_refundable?
    workshop.start_date > Date.today
  end

end
