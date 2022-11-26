class WelcomesController < ApplicationController

def index
    @upcoming_workshops = Workshop.upcoming_workshops.all
    @past_workshops = Workshop.past_workshops.all
end

end