class UsersController < ApplicationController
  def create
    @user = User.create(params.require(:user).permit(:username, :nickname, :profile_pic, :password))
  end
end
