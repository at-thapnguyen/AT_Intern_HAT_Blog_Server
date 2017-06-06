class Api::V1::FollowUsersController < BaseController
  #User follow. When user click button follow
  before_action :authentication!, only: [:index,:show]

  def index
    user = User.find_by_username params[:user_username]
    if user.present?
      follower_ids = FollowUser.where(follower_id: current_user.id).pluck(:user_id)
      render json: User.where(id: follower_ids)
    else
      render json: { users: Array.new }
    end
  end
  # On click follow user
  def create
    user = User.find_by_username params[:user_username]
    follower = FollowUser.find_by user_id: user.id , follower_id: current_user.id
    if follower.blank?
      #be_followed_id is people go follow orther people (current_user)
      follow_user = FollowUser.create user_id: user.id , follower_id: current_user.id
      message = "#{ current_user.username } started following you"
      follow_user.notifications.create user_id: user.id, message: message, image: current_user.avatar
    else
      follower.destroy
    end
    render json: { status: 200 }
  end

end
