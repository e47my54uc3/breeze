class  UsersController < ApplicationController
  
  def show
    user = User.where(params[:id]).first
    render :json => user
  end


end