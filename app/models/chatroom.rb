class Chatroom < ApplicationRecord
  validates :topic, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :creator, presence: true
  validates :topic, exclusion: { in: %w(new),
      message: "%{value} is reserved." }

  has_many :members
  has_many :users, through: :members
  has_many :posts, dependent: :destroy

  def to_param
    slug
  end
end
