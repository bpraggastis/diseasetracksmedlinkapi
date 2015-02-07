class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def create
    @user = User.find_by(email: params[:email])
    raise
    if @user.password_digest == params[:password]
      session[:user_id] = @user.id.to_s
    else
    end
    raise
  end

end
