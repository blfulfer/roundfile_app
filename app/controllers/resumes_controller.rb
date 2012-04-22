class ResumesController < ApplicationController
  
  def show
	@title = "View Resume"
	@resume = Resume.find(params[:id])
	
	
	@resumesection = Resumesection.find_all_by_resumeid(params[:id], :order => "orderNum")
	@comment = Comment.find_all_by_resumeid(params[:id], :order => "created_at")
	@rating = Rating.find_all_by_resumeid(params[:id], :order => "created_at")
	@usercurrentrating = Rating.find_by_resumeid_and_userid(params[:id], current_user.id)
	
	#@section = Section.find(:all)
	
	
  end
  
  def new
    @title = "Name Your Resume"
	@resume = Resume.new
  end
  
  def create	
    @resume = current_user.resumes.build(params[:resume])
    if @resume.save
      flash[:success] = "Resume created!"
      redirect_to "/newresume/#{@resume.id}"
	else
      @title = "Create Resume"
      render 'new'
    end
  end
  
  def allresumes
	@title = "All Resumes"
	@resume = Resume.all
	
	#code from DEMO APP
	respond_to do |format|
      format.html
      format.xml  { render :xml => @resume }
    end
  end
	
  def myresumes
	@title2 = "My Resumes"
	@resume = Resume.find_all_by_userid(current_user.id)
	@user = User.find(current_user.id)
	@title = @user.name
	
	
	#code from DEMO APP
	respond_to do |format|
      format.html 
      format.xml  { render :xml => @resume }
    end
  end
  
  def userres
	@title = "Find Resumes by User"
	@user = User.find(:all)
	@resume = Resume.find_all_by_userid(params[:id])
	if (!params[:id].blank?)
		@userselected = User.find(params[:id])
		@title2 = "#{@userselected.name}'s Resumes"
	else
		@title2 = " "
	end
	
  end
  
  def edit
	@title = "Edit Resume"
    @resume = Resume.find(params[:id])
  end
  
  def update
	@title = "Edit Resume"

    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to("/newresumelist/#{@resume.id}", :notice => 'Resume Title was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resume.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
	
	
	redirect_to :action => 'myresumes'

  end


  
end
