class User < ApplicationRecord
  has_secure_password
  has_many :videos
  has_and_belongs_to_many :rooms
  validates :username, :nickname, presence: { message: 'is empty' }
  validates :username, uniqueness: { message: '%{value} already exists' }

  def as_json(options = {})
    super(options.merge({ except: [:password_digest, :id] }))
  end
end
