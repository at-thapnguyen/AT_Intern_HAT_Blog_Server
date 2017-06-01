class Api::V1::LikesController < BaseController
  before_action :authentication!

  def create
    attention = Attention
    count_likes = attention.like_action params[:article_id], current_user
    render json: { status: 200, count_like: count_likes }
  end
end
