class Api::V1::CommentsController < BaseController

  def index
    render json: comments = Comment.all
  end
  def create
    binding.pry
    if current_user
      comment = Comment.new(comment_params)
      comment.user_id = current_user.id
      comment.article_id = params[:article_id]
      comment.save
      render json: {status: 200}
    else
      render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
    end
  end
  def update
    if current_user
      comment = Comment.find(params[:id])
      comment.update(comment_params)
       comment.article_id = params[:article_id]
      render json: {status: 200}
    else
      render json: { status: "unsuccess",message: "you should login",code: 406}
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
    params.require(:comments).permit(:content)
  end
end
