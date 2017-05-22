class Api::V1::LikesController < BaseController
  before_action :authentication!

  def show
    if current_user.present?
      #Check user liked this article? If not yet then create new, opposite
      attention = Attention.find_by article_id: params[:id], user_id: current_user.id, types: 1
      if attention.blank?
        attention = Attention.create article_id: params[:id], user_id: current_user.id
        message = "<span class='notifice'>#{ current_user.username }</span> liked your post <b> #{ attention.article.content[0..10] }</b>"
        user_be_followed_id = Article.find(params[:id]).user_id
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
