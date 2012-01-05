class WelcomeController < ApplicationController
  #caches_page :index, :about_ashtanga_yoga, :good_to_know, :our_studio, :location
  
  def index
    @current_courses = Course.current.find(:all, :limit => 4)
    @planned_courses = Course.planned.find(:all, :limit => 4)    
    @sessions = Session.current.active(true).asc.all(:limit => 5)
    @gift_certificate_types = GiftCertificateType.active.all
    @gift_certificate = GiftCertificate.new(:coupon_type => GiftCertificateType.first)
    @test_course = Course.current_or_planned.free.first
    @test_session = @test_course.next_session if @test_course
    @jonas = Instructor.find(1)    
    @introduction_course = Workshop.find(40)  
  end
  
  def about_ashtanga_yoga; end
  def good_to_know; end
  def our_studio; end
  def location; end
  def introduction_course
    @introduction_course = Workshop.find(40)  
  end
  
  def colors
    render :layout => false
  end
end
