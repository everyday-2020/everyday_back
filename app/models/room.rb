class Room < ApplicationRecord
  has_many :videos
  has_and_belongs_to_many :users
  validates :title, :complete_at, :invite_code, presence: { message: 'is empty' }
  validates :invite_code, uniqueness: { message: '%{value} is already exists' }
end
