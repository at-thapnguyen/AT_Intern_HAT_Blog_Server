class Api::V1::CommentsController < BaseController

  def index
    @article = Article.find_by_slug!(params[:article_slug])
    render json: @comments = @article.comments.order(created_at: :desc)
  end

  def create
    @article = Article.find_by_slug!(params[:article_slug])
    if current_user
      comment = Comment.new(comment_params)
      comment.user_id = current_user.id
      comment.article_id = @article.id
      comment.save
      if comment.user_id == @article.attributes["user_id"]
      render json: comment,serializer: CommentSerializer
      else 
      message = "#{ current_user.username } commented your article"
      comment.notifications.create user_id: @article.attributes["user_id"], message: message, image: current_user.avatar
      render json: comment,serializer: CommentSerializer
      end
    else
      render json: { status: "unsuccess",message:"you must login",code: 406 }
    end
  end

  def update
    @article = Article.find_by_slug!(params[:article_slug])
    if current_user
      comment = Comment.find(params[:id])
      comment.update(comment_params)
      comment.user_id = current_user.id
      comment.article_id = @article.id
      render json: {status: 200}
    else
      render json: { status: "unsuccess",message: "you should login",code: 406}
    end
  end

  def destroy
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