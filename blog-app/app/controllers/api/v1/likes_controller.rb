class Api::V1::LikesController < BaseController
  before_action :authentication!

  def show
    if current_user.present?
      #Check user liked this article? If not yet then create new, opposite
      attention = Attention.find_by article_id: params[:id], user_id: current_user.id, isLiked: 1
      if attention.blank?
        attention = Attention.create article_id: params[:id], user_id: current_user.id, isLiked: 1
        message = "#{ current_user.username } liked your post #{ attention.article.content[0..10] }"
        article = Article.find(params[:id])
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
