class Api::V1::Articles::HotArticlesController < BaseController
  def index
    render json: Article.all.order(count_like: :desc).limit(5), each_serializer: ::Articles::ArticleHomePageForUserSerializer
  end
end