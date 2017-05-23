class Api::V1::CommentsController < BaseController
  def index
    render json: comments = Comment.all
  end
  def create
    if current_user
      comment = Comment.new(comment_params)
      comment.user_id = current_user.id
      comment.save
      render json: {status: 200}
    else
      render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
    end
  end
  def destroy
    binding.pry
      if current_user.present?
       comment = Comment.find(params[:id])
       comment.destroy
       render json: {status: 200 ,message:"deleted success"}
       else
       render json: {status: "unsuccess",message:"you must confirm email"}
       end
    end



  private
  def comment_params
    params.require(:comments).permit(:content,:article_id)
  end
end
