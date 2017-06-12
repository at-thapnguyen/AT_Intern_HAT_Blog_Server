class Api::V1::LikesController < BaseController
  before_action :authentication!, only: [:create]

  def create
    attention = Attention
    count_likes = attention.like_action params[:article_slug], current_user
    render json: { status: 200, count_likes: count_likes }
  end
end
