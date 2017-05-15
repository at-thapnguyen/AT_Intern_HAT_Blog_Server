class Api::V1::ArticlesController < ApplicationController
	def index
		# article = Article.page(params[:page] ? params[:page][:number] : 1)
		render json: Article.all,meta: {status:400}

	end

	def show
		render json: Article.find(params[:id])
	end

	end

