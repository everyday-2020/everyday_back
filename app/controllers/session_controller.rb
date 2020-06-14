class SessionController < ApplicationController
  def create
    @user = User.find_by(name: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      render status: 200
    else
      render status: 400
    end
  end

  def destroy
    session[:user_id] = nil
    render status: 200
  end
end
