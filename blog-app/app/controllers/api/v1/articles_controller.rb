class Api::V1::ArticlesController < BaseController

  before_action :authentication! , except: [:index]

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
    limit_item = 10 if params[:limit].to_i <= 0
    articles = Article
    articles = articles.filter_category_tag_is_login params[:category_id], params[:tag_id], current_user
    render json: articles.offset(page*limit_item).limit(limit_item), each_serializer: ::Articles::ArticleHomePageForUserSerializer, meta: { total: articles.size, limit: limit_item }
  end

  def show
    render json: Article.friendly.find(params[:id]), serializer: Article::ShowSerializer
  end

  def create
    binding.pry
    if current_user
      article = Article.create title: params[:title], content:params[:content],
      title_image: params[:title_image]  , category_id: params[:category_id], user_id: current_user.id
      # params[:article][:titletle_image].original_filename = rename_file params[:article][:title_image].original_filename
      article.save
      @tags= params[:tags]
      @tags.split(',').each do |f|
      @tag= Tag.find_or_create_by(name: f)
      article.articles_tags.create(tag_id: @tag.id)
      end
      render json: {id: article.id ,slug: article.slug,status: 200,message:"article was sucessfully create"}
    else
        render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
        end
    end

    def update
    if current_user
      article = Article.friendly.find(params[:id])
      if article.update title: params[:title], content:params[:content],
      title_image: params[:title_image]  , category_id: params[:category_id], user_id: current_user.id
      article.save
            @tags= params[:tags].split(',')
            articles_tags = article.tags.map{ |tag| tag.name }
            (@tags - articles_tags).each do |f|
              binding.pry
              if f.present?
                @tag = Tag.find_or_create_by(name: f)
                article.articles_tags.create(tag_id: @tag.id)
              end
            end
            (articles_tags - @tags).each do |f|
              if f.present?
                @tag = Tag.find_by(name: f)
                article.articles_tags.find_by(tag_id: @tag.id).destroy
              end
            end
            binding.pry
          render json: { id: article.id ,slug: article.slug,status: 200, message:"article was sucessfully update article"}
          end
      else
          render json: { status: "unsuccess",message:"you must confirm email",code: 406 }
      end
    end

    def destroy
      if current_user.present?
       article = Article.find(params[:id])
       article.update_columns deleted: true
       render json: {status: 200 ,message:"deleted success"}
      else
       render json: {status: "unsuccess",message:"you must confirm email"}
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


