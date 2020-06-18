require 'digest'

class RoomsController < ApplicationController
  before_action :auth

  def index
    render json: @user.rooms
  end

  def show
    begin
      @room = Room.find_by! invite_code: params[:invite_code]
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
      return
    end
    if !@room.users.exists?(@user.id)
      render status: :forbidden, json: @room
    else
      render json: @room
    end
  end

  def create
    @room = Room.new(params.require('room').permit(:title, :description, :complete_at, :category))
    @room.invite_code = (Digest::SHA256.base64digest(@user.username + params[:room][:title].to_s + Time.zone.now.ctime)[0..5]).gsub('+', '-').gsub('/', '*')
    @room.users << @user
    @room.save
    if @room.valid?
      render status: :ok
    else
      render status: :bad_request, json: @room.errors.full_messages
    end
  end

  def join
    begin
      @room = Room.find_by! invite_code: params[:invite_code]
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
      return
    end
    if not @room.users.exists? @user.id
      @room.users << @user
    end
    render status: :ok
  end

  private

  def auth
    @user = User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end
end
