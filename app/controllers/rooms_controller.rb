require 'digest'

class RoomsController < ApplicationController
  before_action :auth

  def index
    render json: @user.rooms
  end

  def create
    @room = Room.new(params.require('room').permit(:title, :description, :complete_at, :category))
    @room.invite_code = Digest::SHA256.base64digest(@user.username + params[:room][:title].to_s + Time.zone.now.ctime)[0..5]
    @room.users << @user
    @room.save
    if @room.valid?
      render status: :ok
    else
      render status: :bad_request, json: @room.errors.full_messages
    end
  end

  private

  def auth
    @user = User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    render status: :forbidden unless @user
  end
end
