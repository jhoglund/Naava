class Admin::AttendantsController < Admin::AdminController

  def index
    if params[:session_id]
      @session = Session.find(params[:session_id])
    else
      @sessions = Session.all(:order => 'starts_at')
    end
    respond_to do |format|
      format.html do
        if @session
          bookings = @session.bookings + @session.course.bookings
          @participants = @session.attendants.map(&:participant)
          bookings.each do |booking|
            @session.attendants.build(:participant => booking.participant) unless @participants.include?(booking.participant)
          end
          render :template => '/admin/attendants/edit'
        end
      end
      format.xml  { render :xml => @attendants }
    end
  end
  
  def search
    if params[:only_attending]
      @attendants = Attendant.search(:name => params[:name]).attending.all
    else
      @attendants = Attendant.search(:name => params[:name]).all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendants }
    end
  end
  

  def create
    @session = Session.find(params[:session_id])
    respond_to do |format|
      if @session.update_attributes(params[:session])
        flash[:notice] = 'Attendant was successfully updated.'
        format.html { redirect_to(admin_session_attendants_path(@session)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attendant.errors, :status => :unprocessable_entity }
      end
    end
  end
end
