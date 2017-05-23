class Api::V1::FollowUsersController < BaseController
  #User follow. When user click button follow
  before_action :authentication!
  def show
    if current_user.present?
      follower = FollowUser.find_by user_id: params[:id], be_followed_id: current_user.id
      if follower.blank?
        #be_followed_id is people go follow orther people (current_user)
        follow_user = FollowUser.create user_id: params[:id], be_followed_id: current_user.id
        message = "#{ current_user.username } started following you"
        follow_user.notifications.create user_id: params[:id], message: message, image: current_user.avatar
      else
        follower.destroy
      end
      render json: { status: 200 }
    else
      render json: { errors: ['Authorization for this user!']}
    end
  end
end
