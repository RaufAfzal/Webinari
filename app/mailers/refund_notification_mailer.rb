class RefundNotificationMailer < ApplicationMailer

  def customer_refund_notification(refund)
    @refund = refund
    @booking = @refund.booking
    @workshop = @booking.workshop
    @customer = @booking.customer
    @refundable_amount = @refund.no_of_tickets.to_i * @workshop.registration_fee

    mail to: @customer.email, subject: "Refund accepted for #{@workshop.name}" 
  end

  def admin_refund_notification(refund)
    @refund = refund
    @booking = @refund.booking
    @workshop = @booking.workshop
    @customer = @booking.customer
    @refundable_amount = @refund.no_of_tickets.to_i * @workshop.registration_fee

    mail to: AdminUser.first.email, subject: "Refund request coming for #{@workshop.name}" 
  end
end
