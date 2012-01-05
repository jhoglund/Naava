class InstructorsController < ApplicationController
  #caches_page :index, :show
  def index
    @instructors = Instructor.find(1)

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @instructors }
    end
  end

  def show
    @instructor = Instructor.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @instructor }
    end
  end
end
