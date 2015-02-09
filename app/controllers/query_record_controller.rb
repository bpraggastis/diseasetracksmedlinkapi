class QueryRecordController < ApplicationController

  def create
    
  end

  def show

  end

  def destroy
    @record = QueryRecord.find(params[:id])
    @user = User.find(session[:user_id])
    if @record.user_id == @user.id
      @record.delete
      flash[:notice] = "Query record successfully deleted."
      redirect_to @user
    else
      flash[:notice] = "You are not authorized to delete that query."
      redirect_to @user
    end
  end

end
