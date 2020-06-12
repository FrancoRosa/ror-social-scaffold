class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])
    friendship.save
    redirect_to users_path, notice: 'invitation was sent successfully'
  end

  def update
    User.find(params[:user_id]).confirm_friend(User.find(params[:id]))
    redirect_to users_path, notice: 'Invitation accepted successfully'
  end

  def destroy
    Friendship.find_by(user: params[:user_id], friend: params[:id])
    redirect_to users_path, notice: 'Invitation declined successfully'
  end
end
