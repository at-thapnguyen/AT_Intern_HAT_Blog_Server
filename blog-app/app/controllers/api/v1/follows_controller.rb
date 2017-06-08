class Api::V1::FollowsController < BaseController
  #User Login
  before_action :authentication!, only: [:create]

  def create
    attention = Attention
    attention.follow_action params[:article_slug], current_user
    render json: { status: 200 }
  end

end
