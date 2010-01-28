class AttendantsController < ApplicationController
  # GET /attendants
  # GET /attendants.xml
  def index
    @attendants = Attendant.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attendants }
    end
  end

  # GET /attendants/1
  # GET /attendants/1.xml
  def show
    @attendant = Attendant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attendant }
    end
  end

  # GET /attendants/new
  # GET /attendants/new.xml
  def new
    @attendant = Attendant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attendant }
    end
  end

  # GET /attendants/1/edit
  def edit
    @attendant = Attendant.find(params[:id])
  end

  # POST /attendants
  # POST /attendants.xml
  def create
    @attendant = Attendant.new(params[:attendant])

    respond_to do |format|
      if @attendant.save
        flash[:notice] = 'Attendant was successfully created.'
        format.html { redirect_to(@attendant) }
        format.xml  { render :xml => @attendant, :status => :created, :location => @attendant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attendant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attendants/1
  # PUT /attendants/1.xml
  def update
    @attendant = Attendant.find(params[:id])

    respond_to do |format|
      if @attendant.update_attributes(params[:attendant])
        flash[:notice] = 'Attendant was successfully updated.'
        format.html { redirect_to(@attendant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attendant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attendants/1
  # DELETE /attendants/1.xml
  def destroy
    @attendant = Attendant.find(params[:id])
    @attendant.destroy

    respond_to do |format|
      format.html { redirect_to(attendants_url) }
      format.xml  { head :ok }
    end
  end
end
