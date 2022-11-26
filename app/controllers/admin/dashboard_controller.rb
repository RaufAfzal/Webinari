class Admin::DashboardController < AdminController
    def index
        @workshop_count = Workshop.count
        @booking_count = Booking.count
        @upcoming_workshop_count = Workshop.upcoming_workshops.count
        @past_workshop_count = Workshop.past_workshops.count
        @customer_count = Customer.count
        @revenue_earned = Booking.pluck(:amount_paid).sum

        @refundable_booking = Booking.includes(:workshop).where('workshops.start_date > ?', Date.today).references(:workshops)
        @active_refunds = Booking.includes(:refunds).where(refunds: {state: "accepted"})

    end
end