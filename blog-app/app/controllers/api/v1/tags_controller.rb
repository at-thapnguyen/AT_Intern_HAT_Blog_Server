class Api::V1::TagsController < ApplicationController
	def index
		render json: tags = Tag.all
	end
	def show
		render json: tag = Tag.find(params[:id])
	end
end