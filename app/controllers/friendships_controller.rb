class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])
    friendship.save
    redirect_to users_path, notice: 'invitation was sent successfully'
  end
end
