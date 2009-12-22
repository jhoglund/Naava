class CoursesController < BookingsController

  def index
    @courses = Course.active.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  def show
    begin
      @course = Course.find(params[:id])
      @booking = Booking.new(:booker => @course)
    
      respond_to do |format|
        format.html {  }# show.html.erb
        format.xml  { render :xml => @course }
      end
    rescue
      flash[:error] = "Kursen du efterfrågade finns inte"
    end
  end
  
  def book
    @booker = Course.find(params[:id])
    super
  end
  
  def reciept
    
  end
    
end
