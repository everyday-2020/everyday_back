class UsersController < ApplicationController
  before_action :auth
  skip_before_action :auth, only: [:create]

  def create
    @user = User.create(params.require(:user).permit(:username, :nickname, :profile_pic, :password))
    if @user.valid?
      render status: :ok
    else
      render status: :bad_request, json: @user.errors.full_messages
    end
  end

  def show
    render json: @user
  end

  private

  def auth
    @user = User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    render status: :forbidden
  end
end
