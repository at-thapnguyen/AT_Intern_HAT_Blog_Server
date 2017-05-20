class Api::V1::ArticlesController < BaseController

  def index
    binding.pry
    articles = Article.all.includes(:comments, :attentions, :user)
    render json: articles, each_serializer: Article::ArticleSerializer, meta: { total: articles.count, limit: 10 }
  end

  def show
    render json: Article.find(params[:id]), serializer: ShowArticleSerializer
  end

  def create
    user = check_login response.request.env["HTTP_ACCESS_TOKEN"]
    if !user.blank?
      article = Article.new(article_params)
      # params[:article][:titletle_image].original_filename = rename_file params[:article][:title_image].original_filename
      article.title = params[:article][:title]
      article.content = params[:article][:content]
      article.title_image = params[:article][:title_image]
      article.category_id = params[:article][:category_id]

      article.user_id = user.id
       article.save
        render json: {status: 200}
        else
        render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
        end
    end

    def update
      user = check_login response.request.env["HTTP_ACCESS_TOKEN"]
      if !user.blank?
        article = Article.find(params[:id])
        article.update(article_params)
        article.title = params[:article][:title]
        article.content = params[:article][:content]
        article.title_image = params[:article][:title_image]
        article.category_id = params[:article][:category_id]
        article.user_id = user.id
          render json: {status: 200}
      else
          render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
      end
    end

  private

  def article_params
    params.require(:article).permit :title,:content,:title_image,
    :category_id,:createDay,:user_id,:deleted
  end

  def rename_file filename, change_name
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end
end


