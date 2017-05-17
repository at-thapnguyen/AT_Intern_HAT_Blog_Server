class Api::V1::FollowersController < BaseController
  #User follow. When user click button follow
  def index
    user = check_login
    if !user.blank?
      #Check user did follow this people
      isFollowed = FollowUser.find_by user_id: params[:id], be_followed_id: user.id
      FollowUser.create user_id: params[:id], be_followed_id: user.id if isFollowed.blank?
      render json: { status: 200 }
    else
      render json: { errors: ['Authorization for this user!']}
    end
  end

  #User unfollow. When user click button unfollow
  def destroy
    user = check_login
    if !user.blank?
      follower = FollowUser.find_by user_id: params[:id], be_followed_id: user.id
      follower.destroy if !follower.blank?
      render json: { status: 200 }
    else
      render json: { errors: ['Authorization for this user!']}
    end
  end

end
