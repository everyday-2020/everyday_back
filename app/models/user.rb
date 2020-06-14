class User < ApplicationRecord
  has_secure_password
  has_many :videos
  has_and_belongs_to_many :rooms
end
