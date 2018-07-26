class ProfilesController < ApplicationController
  # GET request to /users/:user_id/profile/new
  def new
    # Render blank profile form
    @profile = Profile.new
  end
  
  def create
    
  end
end