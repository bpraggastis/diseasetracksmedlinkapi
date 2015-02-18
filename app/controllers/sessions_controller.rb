class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user == @user.authenticate(params[:password])
      session[:user_id] = @user.id.to_s
      redirect_to root_path
    else
      flash[:notice] = "Email or password is incorrect."
      redirect_to root_path
    end
  end

end
