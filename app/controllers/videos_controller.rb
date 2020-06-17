require 'streamio-ffmpeg'

class VideosController < ApplicationController
    before_action :auth

    def create
        @video = Video.new(video_params)
        @video.clip = params[:clip]
        @video.invite_code = params[:invite_code]
        puts(@video.invite_code)
        begin
            @room = Room.find_by! invite_code: @video.invite_code
        rescue ActiveRecord::RecordNotFound
            render status: :bad_request
            return
        end

        @video.room_id = @room.id
        @video.user_id = @user.id
        
        @video.clicks = 0
        
        @video.file_path = @video.clip.current_path
        @streamio_video = FFMPEG::Movie.new(@video.clip.current_path)
        
        # save length in milliseconds
        @video.length = @streamio_video.duration * 1000
        
        @video.save!

        if @video.valid?
            render status: :ok
        else
            render status: :bad_request, json: @video.errors.full_messages
        end
    end

    # returns a video with id?
    def show
        begin
        @video = Video.find_by! id: params[:id]
        
        rescue ActiveRecord::RecordNotFound
            render status: :not_found
            return
        end
        @video.clicks += 1
        @video.save!
        render json: @video.clip.url
    end

    # returns list of videos in a room
    def index
        begin
        @room = Room.find_by! invite_code: params[:invite_code]

        rescue ActiveRecord::RecordNotFound
            render status: :not_found
            return
        end

        render json: @room.videos.where(:created_at => params[:date_start]..params[:date_end])
    end


    def auth
        @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
        render status: :forbidden
    end

    private
    def video_params
        params.permit(:clip, :invite_code)
    end
end
