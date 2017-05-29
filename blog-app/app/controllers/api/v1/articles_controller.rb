class Api::V1::ArticlesController < BaseController

  before_action :authentication!

  def index
    # Kiem tra use dang nhap
    # => Kiem tra params[:category_id] va params[:tag_id]
    # => Neu 2 params is blank? => Show het tat ca
    # => Neu params[:category_id] is present? va params[:tag_id] is blank? => thi loc theo category
    # => Neu params[:tag_id] is present? va params[:category_id] is blank? => thi loc theo category
    # => Neu params[:tag_id], va params[:category_id] is present? => thi loc theo category
    # Viet ham phan trang skip and take dua vao tham so params[:limit] va params[:current_page]
    # => list = Article.offset(params[:current_page]*params[:limit]).limit(params[:limit])
    current_page = params[:current_page].to_i-1
    limit_item = params[:limit].to_i
    if limit_item < 0 || current_page < 0
      render json: { errors: [ status: 404, message: [{ valid: "Page not found!" }] ]}
    else
      if current_user.blank?
        handle_action_index current_page, limit_item, params[:category_id], params[:tag_id]
      else
        Article.user_id = current_user.id
        handle_action_index current_page, limit_item, params[:category_id], params[:tag_id]
      end
    end
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

  def handle_action_index current_page, limit_item, category_id, tag_id
    if category_id.blank? && tag_id.blank?
        articles = Article.offset(current_page*limit_item).limit(limit_item).includes(:comments)
        render json: articles, each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: Article.all.size, limit: limit_item }
      elsif category_id.present? && tag_id.blank?
        # articles = Article.all.where(category_id: category_id.to_i)
        articles = Article.all.where(category_id: category_id.to_i).includes(:comments)
        render json: articles.offset(current_page*limit_item).limit(limit_item), each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: articles.size, limit: limit_item }
      elsif category_id.blank? && tag_id.present?
        tag = Tag.find tag_id.to_i
        articles = tag.articles.includes(:comments)
        render json: articles.offset(current_page*limit_item).limit(limit_item), each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: articles.size, limit: limit_item }
      else
        tag = Tag.find tag_id.to_i
        articles = tag.articles.where(category_id: category_id.to_i).includes(:comments)
        render json: articles.offset(current_page*limit_item).limit(limit_item), each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: articles.size, limit: limit_item }
      end
  end

  def article_params
    params.require(:article).permit :title,:content,:title_image,
    :category_id,:createDay,:user_id,:deleted
  end

  def rename_file filename, change_name
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end
end


