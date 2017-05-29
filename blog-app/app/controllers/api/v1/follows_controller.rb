class Api::V1::FollowsController < BaseController
  #User Login
  before_action :authentication!

  def show
    if current_user.present?
      #Check user followed this article? If not yet then create new, opposite
      attention = Attention.find_by article_id: params[:id], user_id: current_user.id, isFollowed: 1
      if attention.blank?
        attention = Attention.create article_id: params[:id], user_id: current_user.id, isFollowed: 1
        article = Article.find(params[:id])
        message = "#{ current_user.username } followed your #{ article.title }"
        attention.notifications.create user_id: article.user_id, message: message, image: article.title_image
      else
        attention.destroy
      end
      render json: { status: 200 }
    else
      render json: { errors: [ status: 400, message: [{ valid: "Authorization for this user!" }] ]}
    end
  end

end
