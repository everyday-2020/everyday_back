require 'streamio-ffmpeg'

class VideosController < ApplicationController
    before_action :auth

    def create
        @video = Video.new(video_params)
        @video.clip = params[:clip]
        @video.invite_code = params[:invite_code]
        puts(@video.invite_code)

        @video.room_id = @room.id
        @video.user_id = @user.id
        
        @video.clicks = 0
        @video.length = 0
        @video.file_path = ""
        
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
        rescue ActiveRecord::RecordNotFound
            render status: :not_found
            return
        end

        render json: @room.videos
            .joins( :user )
            .where(:created_at => params[:date_start]..params[:date_end] )
            .select('videos.created_at as created_at, videos.id as id, clicks, clip, length, users.nickname as user_nickname')
    end


    def auth
        if params[:invite_code]
            begin
                @room = Room.find_by! invite_code: params[:invite_code]
            rescue ActiveRecord::RecordNotFound
                render status: :bad_request
                return
            end
        end
        begin
            @user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
            render status: :unauthorized
            return
        end
        if @room and !@room.users.exists?(@user.id)
            render status: :forbidden
            return
        end
    end

    private
    def video_params
        params.permit(:clip, :invite_code)
    end
end
