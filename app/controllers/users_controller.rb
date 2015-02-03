class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_id] = @user.id
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def show
    #Only logged-in users can view their own pages
    @user = User.find(session[:session_id])
  end

  def update
    #This allows users to update their own info, and admins to update tier status
    @user = User.find(params[:user_id])
  end

  def delete
    #This allows users to delete themselves, or admins to delete them.
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
