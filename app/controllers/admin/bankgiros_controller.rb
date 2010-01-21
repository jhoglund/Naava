class Admin::BankgirosController < Admin::AdminController

  def index
    @bankgiros = Bankgiro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bankgiros }
    end
  end

  def show
    @bankgiro = Bankgiro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bankgiro }
    end
  end

  def new
    @bankgiro = Bankgiro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bankgiro }
    end
  end

  def edit
    @bankgiro = Bankgiro.find(params[:id])
  end

  def create
    @bankgiro = Bankgiro.new(params[:bankgiro])

    respond_to do |format|
      if @bankgiro.save
        flash[:notice] = 'Bankgiro was successfully created.'
        format.html { redirect_to(@bankgiro) }
        format.xml  { render :xml => @bankgiro, :status => :created, :location => @bankgiro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bankgiro.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bankgiro = Bankgiro.find(params[:id])

    respond_to do |format|
      if @bankgiro.update_attributes(params[:bankgiro])
        flash[:notice] = 'Bankgiro was successfully updated.'
        format.html { redirect_to(@bankgiro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bankgiro.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bankgiro = Bankgiro.find(params[:id])
    @bankgiro.destroy

    respond_to do |format|
      format.html { redirect_to(bankgiros_url) }
      format.xml  { head :ok }
    end
  end
end
