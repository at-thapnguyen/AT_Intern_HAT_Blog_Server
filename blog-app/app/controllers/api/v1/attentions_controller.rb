class Api::V1::AttentionsController < BaseController

  def create
    if current_user.present?
      #kiem tra record attention da xuat hien chua? neu co thi tao moi. khong thi xoa di
      attention = Attention.find_by article_id: params[:article_id], user_id: current_user.id, types: 1
      if attention.blank?
        attention = Attention.create article_id: params[:article_id], user_id: current_user.id
        # message = "<span class='notifice'>#{ current_user.username }</span> liked your post <b> #{ attention.article.content[0..10] }</b>"
        message = "<span class='notifice'>#{ current_user.username }</span> started following you"
        user_id_be_followed = Article.find(params[:article_id]).user_id
        attention.notifications.create user_id: user_id_be_followed, message: message
      else
        attention.destroy
      end
      render json: { status: 200 }
    else
      render json: { errors: [ status: 400, message: [{ valid: "Authorization for this user!" }] ]}
    end
  end

end
