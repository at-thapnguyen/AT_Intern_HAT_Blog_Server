class Api::V1::AttentionsController < BaseController

  def index
    #Like button response.request.env["HTTP_ACCESS_TOKEN"]
    user = check_login
    if !user.blank?
      attention = Attention.find_by user_id: user.id, article_id: params[:article_id]
      if !attention.blank?
        attention.update isLiked: attention.isLiked ? false : true if !params[:isLiked].blank?
        attention.update isFollowed: attention.isFollowed ? false : true if !params[:isFollowed].blank?
      else
        Attention.create user_id: user.id, article_id: params[:article_id], isLiked: true, notification_like: true if !params[:isLiked].blank?
        Attention.create user_id: user.id, article_id: params[:article_id], isFollowed: true, notification_follow: true if !params[:isFollowed].blank?
      end
      msg = { status: 200 }
      render json: msg
    else
      render json: { errors: [ status: 400, message: [{ valid: "You are not logged in" }] ]}
    end
  end

end
