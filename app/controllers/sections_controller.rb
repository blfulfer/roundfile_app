class SectionsController < ApplicationController
	before_filter :authenticate, :only => [:create, :show, :new, :allsections, :mysections, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :authorized_user, :only => :destroy
  
  def show
	@section = Section.find(params[:id])
	@title = "View Section"
  end
  
  def new
	@title = "Create a Section"
	@section = Section.new
  end
  
  def create
	#@userID = User.find_by_userid(current_user.userid)
	
    @section = current_user.sections.build(params[:section])
    if @section.save
      #sign_in @user
      flash[:success] = "Section created!"
      redirect_to @section
    else
      @title = "Create Section"
      render 'new'
    end
  end
  
  def allsections
	@title = "All Sections"
	@section = Section.all
	
	#code from DEMO APP
	respond_to do |format|
      format.html
      format.xml  { render :xml => @section }
    end
  end
	
  def mysections
	@title = "My Sections"
	@section = Section.find_all_by_userid(current_user.id, :order => "typesection")
	
	
	#code from DEMO APP
	respond_to do |format|
      format.html 
      format.xml  { render :xml => @section }
    end
  end
  
  
  
  def edit
	@title = "Edit Section"

    @section = Section.find(params[:id])
  end
  
  def update
	@title = "Edit Section"

    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to(@section, :notice => 'Section was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @section = Section.find(params[:id])
    @section.destroy
	
	#@resumesection = Resumesection.destroy_all_by_sectionid(params[:id])
	
	
	redirect_to :action => 'mysections'
    #respond_to do |format|
     # format.html { redirect_to(mysections_url) }
     # format.xml  { head :ok }
    #end
  end
  
  private
	
	def authenticate
      deny_access unless signed_in?
    end
	def correct_user
      @section = Section.find(params[:id])
      redirect_to(root_path) unless current_user.id == @section.userid
    end
    def authorized_user
      @section = Section.find(params[:id])
	  
	  if @section.userid != current_user.id
      redirect_to root_path
	  end
    end

end
