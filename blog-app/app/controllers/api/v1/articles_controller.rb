class Api::V1::ArticlesController < BaseController

  def index
   
    articles = Article.all.includes(:comments, :attentions, :user,:tags).limit(params[:limit] || 10)
    render json: articles, each_serializer: Article::IndexSerializer, meta: { total: articles.count}
  
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

  # def article_params
  #   params.require(:article).permit :title,:content,:title_image,
  #   :category_id
  # end

  def rename_file filename, change_name
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end
end


