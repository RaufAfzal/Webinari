class Workshop < ApplicationRecord

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :bookings
    has_many :customers, through: :bookings
    
    validates :name, :description, presence: true
    validates :start_date, :end_date, :start_time, :end_time, presence: true
    validates :total_seats, :registration_fee, presence: true, numericality: true
    validates_comparison_of :end_date, greater_than: :start_date,                 
        other_than: Date.today , message:  "end date must be greater then start date"  
        
        
        scope :upcoming_workshops, -> { where('start_date >= ?' , Date.today)}
        scope :past_workshops, -> { where('end_date < ?' , Date.today)}
        

        def total_duration
            "From #{start_date} to #{end_date}"
        end

        def daily_workshop_hours
            "#{((start_time.to_i - end_time.to_i)).abs} hours"
        end

        def daily_duration
            "Everyday #{start_time} to #{end_time} (#{daily_workshop_hours})"
        end
        
        def is_upcoming_workshop
            start_date >= Date.today
        end
end
