require 'digest'

class RoomsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    render json: user.rooms
  end

  def create
    user = User.find(session[:user_id])
    logger.info params[:title]
    invite_code = Digest::SHA256.base64digest(user.username + params[:room][:title] + Time.zone.now.ctime)[0..5]
    @room = Room.new(params.require('room').permit(:title, :description, :complete_at, :category))
    @room.invite_code = invite_code
    @room.users << user
    @room.save
    render @room
  end
end
