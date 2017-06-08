class Member < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates_uniqueness_of :user_id, { scope: :chatroom_id }
end
