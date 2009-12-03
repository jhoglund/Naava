class WelcomeController < ApplicationController
  
  def index
    @current_courses = Course.current.all
    @planned_courses = Course.planned.all    
    @sessions = Session.by_date.week.all
  end
  
  def about_ashtanga_yoga; end
  def good_to_know; end
  def our_studio; end
  
end
