class WelcomeController < ApplicationController
  
  def index
    @current_courses = Course.current.find(:all, :limit => 3)
    @planned_courses = Course.planned.all    
    @sessions = Session.current.by_date.all(:limit => 3)
  end
  
  def about_ashtanga_yoga; end
  def good_to_know; end
  def our_studio; end
  
end
