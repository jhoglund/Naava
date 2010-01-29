class Admin::CashesController < Admin::AdminController

  def index
    @cashes = Cash.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cashes }
    end
  end

  def show
    @cash = Cash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cash }
    end
  end

  def new
    @cash = Cash.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cash }
    end
  end

  def edit
    @cash = Cash.find(params[:id])
  end

  def create
    @cash = Cash.new(params[:cash])

    respond_to do |format|
      if @cash.save
        flash[:notice] = 'Cash was successfully created.'
        format.html { redirect_to(@cash) }
        format.xml  { render :xml => @cash, :status => :created, :location => @cash }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cash.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @cash = Cash.find(params[:id])

    respond_to do |format|
      if @cash.update_attributes(params[:cash])
        flash[:notice] = 'Cash was successfully updated.'
        format.html { redirect_to(@cash) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cash.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @cash = Cash.find(params[:id])
    @cash.destroy

    respond_to do |format|
      format.html { redirect_to(cashes_url) }
      format.xml  { head :ok }
    end
  end
end
