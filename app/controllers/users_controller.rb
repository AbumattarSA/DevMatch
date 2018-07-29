class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.includes(:profile)
  end
  
  # GET request to /users/:id
  def show
    @user = User.find( params[:id] )
  end
  
  
end