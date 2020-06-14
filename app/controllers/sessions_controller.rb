class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])
    if @user&.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      render status: :ok
    else
      render status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    render status: :ok
  end
end
