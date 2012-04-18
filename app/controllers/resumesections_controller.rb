class ResumesectionsController < ApplicationController
 
	  
  def show
	@resumesection = Resumesection.find(params[:id])
	@title = "Show Resume Sections"
  end
  
  def new
	@title = "New Resume"
	if (!params[:message].blank?)
		flash[:error] = "There was an error adding this section to the resume. Make sure to select a section and enter an order number."
	end
	
	
	@resumesection = Resumesection.new
	
	if (@resumesection.resumeid != nil)
		params[:id] = @resumesection.resumeid
	end
	

	if (Section.find_all_by_userid_and_typesection(current_user.id, 'Contact') != nil)
		@myContact = Section.find_all_by_userid_and_typesection(current_user.id, 'Contact')
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Objective') != nil)
		@myObjective = Section.find_all_by_userid_and_typesection(current_user.id, 'Objective')
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Qualifications') != nil)
		@myQualifications = Section.find_all_by_userid_and_typesection(current_user.id, 'Qualifications')
	
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Education') != nil)
		@myEducation = Section.find_all_by_userid_and_typesection(current_user.id, 'Education')
	
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Skills') != nil)
		@mySkills =	Section.find_all_by_userid_and_typesection(current_user.id, 'Skills')
	
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Employment History') != nil)
		@myEmplHistory = Section.find_all_by_userid_and_typesection(current_user.id, 'Employment History')
	
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'List of References') != nil)
		@myListRef = Section.find_all_by_userid_and_typesection(current_user.id, 'List of References')
	
	end
	
	if(Section.find_all_by_userid_and_typesection(current_user.id, 'Other') != nil)
		@myOther =	Section.find_all_by_userid_and_typesection(current_user.id, 'Other')
	
	end


	
  end
  
  
  def list
	@title = "Resume List"
	@resume = Resume.find(params[:id])
	@resumesection = Resumesection.find_all_by_resumeid(params[:id], :order => "orderNum")
	
	#code from DEMO APP
	#respond_to do |format|
     # format.html 
      #format.xml  { render :xml => @resumesection }
    #end

  end
  
  def create	
    @resumesection = Resumesection.new(params[:resumesection])
	
    if @resumesection.save
      flash[:success] = "Resume Section created!"
      redirect_to "/newresumelist/#{@resumesection.resumeid}"
    else
      @title = "New Resume"
	  redirect_to "/newresume/#{@resumesection.resumeid}/error"
      #render 'new'
	end
  end
  
  
  
  
  def edit
	@title = "Edit Order of Section"
    @resumesection = Resumesection.find(params[:id])
  end
  
  def update
	@title = "Edit Order of Section"

    @resumesection = Resumesection.find(params[:id])

    respond_to do |format|
      if @resumesection.update_attributes(params[:resumesection])
        format.html { redirect_to("/newresumelist/#{@resumesection.resumeid}", :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resumesection.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  
  def destroy

    @resumesection = Resumesection.find(params[:id])
	#@test = @resumesection.resumeid
    @resumesection.destroy

    respond_to do |format|
      format.html { redirect_to("/newresumelist/#{@resumesection.resumeid}") }
      format.xml  { head :ok }
    end
  end

  
end


