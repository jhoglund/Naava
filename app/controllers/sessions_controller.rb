class SessionsController < BookingsController  

  def index
    @sessions = Session.all

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
