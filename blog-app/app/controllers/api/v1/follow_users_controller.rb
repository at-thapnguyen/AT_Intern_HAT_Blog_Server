class Api::V1::FollowUsersController < BaseController
  #User follow. When user click button follow
  before_action :authentication!, only: [:show]

  def index
    user = User.find_by_username params[:user_username]
    if user.present?
      follower_ids = FollowUser.where(be_followed_id: user.id).pluck(:user_id)
      render json: User.where(id: follower_ids)
    else
      render json: { users: Array.new }
    end
  end
  # On click follow user
  def show
    user = User.find_by_username params[:user_username]
    follower = FollowUser.find_by user_id: user.id, be_followed_id: current_user.id
    if follower.blank?
      #be_followed_id is people go follow orther people (current_user)
      follow_user = FollowUser.create user_id: params[:id], be_followed_id: current_user.id
      message = "#{ current_user.username } started following you"
      follow_user.notifications.create user_id: params[:id], message: message, image: current_user.avatar
    else
      follower.destroy
    end
    render json: { status: 200 }
  end

end