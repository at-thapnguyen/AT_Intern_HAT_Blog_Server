class Api::V1::FollowsController < BaseController
  #User Login
  before_action :authentication!

  def create
    if current_user.present?
      #Check user followed this article? If not yet then create new, opposite
      attention = Attention.find_by article_id: params[:article_id], user_id: current_user.id, types: 0
      if attention.blank?
        attention = Attention.create article_id: params[:article_id], user_id: current_user.id, types: 0
        message = "<span class='notifice'>#{ current_user.username }</span> followed your article"
        user_be_followed_id = Article.find(params[:article_id]).user_id
        attention.notifications.create user_id: user_be_followed_id, message: message
      else
        attention.destroy
      end
      render json: { status: 200 }
    else
      render json: { errors: [ status: 400, message: [{ valid: "Authorization for this user!" }] ]}
    end
  end

end
