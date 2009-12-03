class SessionsController < BookingsController  

  def index
    if params[:week]
      @sessions = Session.by_date.week(Date.parse(params[:week])).all
    else
      @sessions = Session.by_date.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sessions }
    end
  end

  def show
    @session = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session }
    end
  end
  
  def book
    @booker = Session.find(params[:id])
    super
  end
  
  def create
    @booker = Session.find(params[:id])
    super
  end

end
