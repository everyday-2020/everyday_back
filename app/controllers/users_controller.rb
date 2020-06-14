class UsersController < ApplicationController
  def create
    @user = User.create(params.require(:user).permit(:username, :nickname, :profile_pic, :password))
    if @user.valid?
      render status: :ok
    else
      render status: :bad_request, json: @user.errors.full_messages
    end
  end
end
