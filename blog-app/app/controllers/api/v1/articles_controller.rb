class Api::V1::ArticlesController < BaseController

  before_action :authentication! , except: [:index, :show]

  def index
    # Kiem tra use dang nhap
    # => Kiem tra params[:category_id] va params[:tag_id]
    # => Neu 2 params is blank? => Show het tat ca
    # => Neu params[:category_id] is present? va params[:tag_id] is blank? => thi loc theo category
    # => Neu params[:tag_id] is present? va params[:category_id] is blank? => thi loc theo category
    # => Neu params[:tag_id], va params[:category_id] is present? => thi loc theo category
    # Viet ham phan trang skip and take dua vao tham so params[:limit] va params[:current_page]
    # => list = Article.offset(params[:current_page]*params[:limit]).limit(params[:limit])
    page = params[:current_page].to_i - 1
    limit_item = params[:limit].to_i
    page = 1 if params[:current_page].to_i <= 0
    limit_item = Const::LIMIT_ITEMS_DEFAULT if params[:limit].to_i <= 0
    articles = Article.includes(:comments, :attentions, :user,:category,:tags)
    articles = articles.filter_category_tag_is_login params[:category_id], params[:tag_id], current_user
    render json: articles.offset(page*limit_item).limit(limit_item), each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: articles.size, limit: limit_item }
  end

  def show
    if current_user.blank? 
    Article.user_id = nil
    render json: Article.includes(:comments, :attentions, :user,:tags).find_by_slug!(params[:slug]), serializer: Article::ShowSerializer
    else    
    Article.user_id = current_user.id
    render json: Article.includes(:comments, :attentions, :user,:tags).find_by_slug!(params[:slug]), serializer: Article::ShowSerializer
    end
  end

  def create
    if current_user
      article = current_user.articles.create(article_params)
      if article.save
        @tags = params[:tags]
        @tags.split(',').each do |f|
        @tag = Tag.find_or_create_by(name: f)
        article.articles_tags.create(tag_id: @tag.id)
        end
      end
      render json: {id: article.id ,slug: article.slug,status: 200,message:"article was sucessfully create"}
    else
      render json: { status: "unsuccess",message:"you must login",code: 406 }
    end
  end

    def update
    if current_user
      article = Article.find_by_slug(params[:slug])
        if params[:title_image].class == String
        article.update title: params[:title], content:params[:content],category_id: params[:category_id], user_id: current_user.id
        article.save
        Article.create_tags article, params[:tags]
      render json: { id: article.id ,slug: article.slug,status: 200, message:"article was sucessfully update "}
      else
        article.update title: params[:title], content: params[:content],title_image: params[:title_image],category_id: params[:category_id], user_id: current_user.id
        article.save
        Article.create_tags article, params[:tags]
      render json: { id: article.id ,slug: article.slug,status: 200, message:"article was sucessfully update"}
      end
    else
      render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
    end
  end

    def destroy
    if current_user.present?
     article = Article.find_by_slug!(params[:slug])
     article.update_columns deleted: true
     render json: {status: 200 ,message:"deleted success"}
    else
     render json: {status: "unsuccess",message:"you must confirm email"}
     end
    end

  private

  def article_params
    params.permit :title,:content,:title_image,:category_id
  end


  def rename_file filename, change_name
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end
end


