class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :only_current_user
  
  # GET request to /users/:user_id/profile/new
  def new
    # Render blank profile form
    @profile = Profile.new
  end
  
  # POST request to /users/:user_id/profile
  def create
    # Identify the user submitting the form
    @user = User.find( params[:user_id] )
    # Create profile for this user ID
    @profile = @user.build_profile( profile_params )
      if @profile.save
        flash[:success] = "Profile updated."
        redirect_to user_path(id: params[:user_id] )
      else
        render action: :new
      end
  end
      
  # GET request to /users/:user_id/profile/edit  
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PUT request to /users/:user_id/profile
  def update
    # Retrive the user's profile from the database
    @user = User.find( params[:user_id] )
    @profile= @user.profile
    # Mass assign edited profile attributes and save
    if @profile.update_attributes(profile_params)
      flash[:success] = "Your profile has successfully been updated."
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id] )
    else
      flash[:danger] = "An error has occured. Please try again."
      render action: :edit
    end
  end
  
  private
    # Strong parameters to allow data collection from form and whitelists
    # the form fields
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end