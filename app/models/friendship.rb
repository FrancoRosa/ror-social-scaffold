class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user, presence: true
  validates :friend, presence: true
  validates :user, uniqueness: { scope: [:friend] }
  before_update :complete_friendship

  private

  def complete_friendship
    Friendship.create(user_id: friend.id, friend_id: user.id, confirmed: true) if confirmed
  end
end
