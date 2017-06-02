class Api::V1::LikesController < BaseController
  before_action :authentication!

  def index
    #Check user liked this article? If not yet then create new, opposite
    attention = Attention.find_by article_id: params[:article_id], user_id: current_user.id, isLiked: 1
    article = Article.find_by_slug(params[:slug])
    if attention.blank?
      attention = Attention.create article_id: params[:article_id], user_id: current_user.id, isLiked: 1
      message = "#{ current_user.username } liked your post #{ attention.article.content[0..10] }"
      article.update_columns count_like: article.count_like + 1
      attention.notifications.create user_id: article.user_id, message: message, image: article.title_image
    else
      article.update_columns count_like: article.count_like - 1
      attention.destroy
    end
    render json: { status: 200 }
  end

end
