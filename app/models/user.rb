class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :inverted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  def friends_and_own_posts
    users = friends << self
    Post.where(user: users)
  end

  def confirm_friend(friend)
    pending_friendships.find_by(friend_id: friend[:id]).update(confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
