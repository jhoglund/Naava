class WelcomeController < ApplicationController
  
  def index
    @current_courses = Course.current.all
    @planned_courses = Course.planned.all    
  end
  
end
