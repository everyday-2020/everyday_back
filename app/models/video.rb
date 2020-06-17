class Video < ApplicationRecord
    belongs_to :user
    belongs_to :room

    mount_uploader :clip, ClipUploader

end
