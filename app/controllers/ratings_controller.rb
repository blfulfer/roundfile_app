class RatingsController < ApplicationController

	before_filter :authenticate, :only => [:create, :show, :new]
	before_filter :authorized_user, :only => :destroy
	
  def new
	@title = "Verify Your Rating"
	@rating = Rating.new
	if (params[:score] == "error")
		flash[:error] = "There was an error adding your rating. Please try again."
	end
	
	
	
  end
  
  def create
    @rating = current_user.ratings.build(params[:rating])
    if @rating.save
      flash[:success] = "Rating created!"
      redirect_to "/viewresume/#{@rating.resumeid}"
	else
      @title = "Create Rating"
	  redirect_to "/newrating/#{@rating.resumeid}/error"
      #render 'new'
    end
  end
  
  def show
	@rating = Rating.find(params[:id])
	@title = "Show Rating"
  end
  
  
  
 
  
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
	
	redirect_to "/viewresume/#{@rating.resumeid}"

  end
  
  private
	
	def authenticate
      deny_access unless signed_in?
    end

    def authorized_user
      #@section = current_user.sections.find_by_id(params[:id])
	  @rating = Rating.find(params[:id])
	  
	  if @rating.userid != current_user.id
		redirect_to root_path
	  end
    end




end
