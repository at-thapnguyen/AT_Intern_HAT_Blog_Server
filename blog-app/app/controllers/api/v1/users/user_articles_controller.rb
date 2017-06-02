class Api::V1::Users::UserArticlesController < ApplicationController
	def index
		@user = User.find_by_username!(params[:username])
		articles = @user.articles
		render json: articles,each_serializer: Article::ShowSerializer
	end
end
