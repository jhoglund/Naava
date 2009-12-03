class WelcomeController < ApplicationController
  
  def index
    @current_courses = Course.current.all
    @planned_courses = Course.planned.all    
    @sessions = Session.by_date.week.all
  end
  
end
