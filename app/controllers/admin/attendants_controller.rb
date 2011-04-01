class Admin::AttendantsController < Admin::AdminController

  def index
    @sessions = Session.all(:order => 'starts_at')
    respond_to do |format|
      format.html
      format.xml  { render :xml => @attendants }
    end
  end
  
  def edit
    @session = Session.find(params[:id])
    respond_to do |format|
      format.html do
        @index = @session.participants.map(&:bookings).map(&:id).max
        render :edit
      end
      format.xml  { render :xml => @attendants }
    end
  end
  alias :show :edit
  
  def update
    @session = Session.find(params[:id])
    respond_to do |format|
      #params[:session].delete_if{|k,v| v[:participant_attributes] && v[:participant_attributes][:name].blank? }
      #delete_flagged
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
  
  def search
    if request.get?
      @attendants = []
    elsif params[:only_attending]
      @attendants = Attendant.search(:name => params[:name]).attending.all
    else
      @attendants = Attendant.search(:name => params[:name]).all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendants }
    end
  end
  
  private
  
  def delete_flagged
    delete_ids = params[:session][:attendants_attributes].map{|k,v| v[:id] if v[:status] == '_delete' }
    params[:session][:attendants_attributes].delete_if{|k,v| v[:status] == '_delete' }
    Attendant.destroy(delete_ids.compact)
  end
end
