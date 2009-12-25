class SessionsController < BookingsController  

  def index
    if params[:week]
      @sessions = Session.asc.week(Date.parse(params[:week])).all
    else
      @sessions = Session.asc.all
    end
    @courses = Course.active.all.sort_by{|c| c.next_session.starts_at}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sessions }
    end
  end

  def show
    begin
      @session = Session.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @session }
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Klassen du efterfrågade finns inte"
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
