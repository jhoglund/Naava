class Admin::SessionsController < Admin::AdminController
  
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

  def new
    @session = Session.new
    @cources = Course.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session }
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def create
    @session = Session.new(params[:session])

    respond_to do |format|
      if @session.save
        flash[:notice] = 'Session was successfully created.'
        format.html { redirect_to(admin_course_session_path(@session.course, @session)) }
        format.xml  { render :xml => @session, :status => :created, :location => @session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sessions/1
  # PUT /sessions/1.xml
  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        flash[:notice] = 'Session was successfully updated.'
        format.html { redirect_to(@session) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to(sessions_url) }
      format.xml  { head :ok }
    end
  end
end
