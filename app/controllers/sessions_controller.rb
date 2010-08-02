class SessionsController < BookingsController  
  #caches_page :index, :show

  def index
    if params[:week]
      @sessions = Session.current.asc.week(Date.parse(params[:week])).all
    else
      @sessions = Session.current.asc.all(:include => :course)
    end
    @courses = Course.current.all.sort_by{|c| c.starts_at}
    @planned_courses = Course.planned.all.sort_by{|c| c.starts_at}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sessions }
      format.json { render :json => @sessions }
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
