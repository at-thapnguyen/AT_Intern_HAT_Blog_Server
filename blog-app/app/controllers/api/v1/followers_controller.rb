class Api::V1::FollowersController < BaseController
  #User follow. When user click button follow
  before_action :authentication!
  def create
    if current_user.present?
      follower = FollowUser.find_by user_id: params[:user_id], be_followed_id: current_user.id
      if follower.blank?
        #be_followed_id is people go follow orther people (current_user)
        follow_user = FollowUser.create user_id: params[:user_id], be_followed_id: current_user.id
        message = "<span class='notifice'>#{ current_user.username }</span> started following you"
        follow_user.notifications.create user_id: params[:user_id], message: message
      else
        follower.destroy
      end
      render json: { status: 200 }
    else
      render json: { errors: ['Authorization for this user!']}
    end
  end
end
