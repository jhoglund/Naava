class Admin::CourseTypesController < Admin::AdminController
  before_filter :require_user

  def index
    @courses = CourseType.find(:all, :order => "id").reverse.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  def show
    @course = CourseType.find(params[:id])
    @booking = Booking.new(:booker => @course)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  def new
    @course = CourseType.new
    @course.sessions.build
    @course.instructor = Instructor.first
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  def edit
    @course = CourseType.find(params[:id])
  end
  
  def clone
    @original = CourseType.find(params[:id])
    @course =  @original.clone
    @course.status = Status::DISABLED
    @original.sessions.each do |session|
      @course.sessions << session.clone
    end
    @course.save
    @course.update_attribute(:ends_at, @original.ends_at)
    redirect_to edit_admin_course_path(@course)
  end
  

  def create
    @course = typecast_class.new(params[class_type_name])

    respond_to do |format|
      if @course.save
        flash[:notice] = 'Course was successfully created.'
        format.html { redirect_to(admin_course_type_path(@course)) }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @course = CourseType.find(params[:id])
    klass = typecast_class

    respond_to do |format|
      if @course.update_attributes(params[class_type_name])
        if !@course.is_a?(klass)
          @course = @course.becomes(klass)
          @course.type = klass.name
          @course.save
        end
        flash[:notice] = 'Course was successfully updated.'
        format.html { redirect_to(admin_course_type_path(@course)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end  

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = CourseType.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(admin_course_types_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def class_type_name
    params[:class_type_name]
  end
  
  def typecast_class
    klass_type = params[class_type_name].delete(:type)
    klass_type.nil? ? CourseType : klass_type.constantize
  end
  
end
