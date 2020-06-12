# rubocop:disable  Style/GuardClause
module UsersHelper
  def invitation_handler(user)
    if current_user != user && !current_user.friend?(user)
      if current_user.pending_friends.include?(user)
        '(invitation  pending)'
      elsif current_user.friend_requests.include?(user)
        render partial: 'treat_invitation', locals: { user: user }
      else
        link_to 'Send Invitation', user_friendships_path(user), method: :post, class: 'btn btn-primary'
      end
    end
  end
end
# rubocop:enable  Style/GuardClause
