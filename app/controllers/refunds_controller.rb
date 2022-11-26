class RefundsController < ApplicationController

    before_action :set_refund_with_parents, only: %i[edit update refund_acceptance]

    def new
        @refund = Refund.new
    end

    def create
        booking = Booking.find_by(order_number: params[:refund][:order_number])
        if booking.present?
            if booking.is_refundable?
            @refund = Refund.create(
                    customer_id: booking.customer_id,
                    booking_id: booking.id,
                    state: "accepted"
                )
                redirect_to edit_refund_path(@refund), notice: "Your booking request is valid. Please fill the other information
                to process."
                else
                    redirect_to new_refund_path, alert: "You are requesting refund for a past workshop. Request are 
                    allowed for the workshop that will be taken in future."
            end
        else
            redirect_to new_refund_path, alert: "Your booking ID is invalid #{ params[:refund][:order_number]}. We 
            found no booking with this particular booking ID. Please provide valid booking ID"

        end

    end

    def edit
       
    end

    def update
        refundable_amount = params[:refund][:no_of_tickets].to_i * @workshop.registration_fee
        if @refund.update(no_of_tickets: params[:refund][:no_of_tickets])
            RefundNotificationMailer.customer_refund_notification(@refund).deliver_now
            RefundNotificationMailer.admin_refund_notification(@refund).deliver_now
            redirect_to  refund_acceptance_refund_path, notice: "You are eligible for refund
            of $#{refundable_amount.to_f}"
        else
            redirect_to  refund_acceptance_refund_path, alert: "Somrthing went wrong"
        end
    rescue StandardError => error
        redirect_to  refund_acceptance_refund_path, alert: error.message
    end

    def refund_acceptance

    end

    private
    def set_refund_with_parents
       @refund = Refund.find(params[:id])
       @booking = @refund.booking
       @workshop = @booking.workshop
    end

end