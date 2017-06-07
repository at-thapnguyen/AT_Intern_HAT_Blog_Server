class Api::V1::TagsController < ApplicationController
	def index
		render json: Tag.popular_tag
	end
	def show
		render json: tag = Tag.find(params[:id])
	end
end