class WorkshopsController < BookingsController
  #caches_page :index, :show
  
  def index
    @courses = Workshop.active.current_or_planned.find(:all, :order => 'course_types.updated_at desc')

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @courses }
    end
  end

  def show
    begin
      @course = Workshop.find(params[:id])
      @booking = Booking.new(:booker => @course)
      respond_to do |format|
        format.html {  }# show.html.haml
        format.xml  { render :xml => @course }
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Kursen du efterfrågade finns inte"
    end
  end
  
  def book
    @booker = Workshop.find(params[:id])
    super
  end
  
  def reciept
    
  end
    
  def alexander_medin
    @booker = Workshop.find(41)
    render :template => '/workshops/alexander_medin_2012/show'
  end
end
