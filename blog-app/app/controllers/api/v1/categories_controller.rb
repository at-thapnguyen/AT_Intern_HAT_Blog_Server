class Api::V1::CategoriesController < ApplicationController
	def index
		render json: categories = Category.all
	end
end
