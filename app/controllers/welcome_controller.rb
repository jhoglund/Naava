class WelcomeController < ApplicationController
  #caches_page :index, :about_ashtanga_yoga, :good_to_know, :our_studio, :location
  
  def index
    @current_courses = Course.current.find(:all, :limit => 4)
    @planned_courses = Course.planned.find(:all, :limit => 4)    
    @sessions = Session.current.active(true).asc.all(:limit => 3)
    @gift_certificate_types = GiftCertificateType.all
    @gift_certificate = GiftCertificate.new(:coupon_type => GiftCertificateType.first)
    @jonas = Instructor.find(1)    
  end
  
  def about_ashtanga_yoga; end
  def good_to_know; end
  def our_studio; end
  def location; end
  
end
