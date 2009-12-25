class Admin::BookingsController < Admin::AdminController
  
  def index
    # TODO: There got to be a better way of doing this
    if params[:course_id]
      @bookings = Course.find(params[:course_id]).bookings
    elsif params[:session_id]
      session = Session.find(params[:session_id])
      @bookings = session.course.bookings
      @bookings << session.bookings
    else
      @bookings = Booking.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  def show
    @booking = Booking.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # def new
  #   # TODO: There got to be a better way of doing this
  #   booker = params[:course_id] ? Course.find(params[:course_id]) : Session.find(params[:session_id])
  #   @booking = Booking.new(:booker => booker)
  #   @booking.participant = Participant.new
  #   
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @booking }
  #   end
  # end

  def edit
    @booking = Booking.find_by_token(params[:id])
  end

  def create
    @booking = Booking.new
    @booking.participant = Participant.new
    @booking.attributes = params[:booking]

    respond_to do |format|
      if @booking.save
        flash[:notice] = 'Bokningen är sparad.'
        format.html { redirect_to(@booking) }
        format.xml  { render :xml => @booking, :status => :created, :location => @booking }
      else
        flash[:error] = 'Bokningen kunde inte sparas.'
        format.html { redirect_to :back, @booking.attributes }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking = Booking.find_by_token(params[:id])
    @booking.destroy

    respond_to do |format|
      flash[:notice] = 'Bokningen är borttagen.'
      format.html { redirect_to(admin_bookings_url) }
      format.xml  { head :ok }
    end
  end
end
