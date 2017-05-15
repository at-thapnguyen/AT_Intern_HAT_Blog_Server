
class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]
  # before_action :validate_user, only: [:create, :update, :destroy]
  # before_action :validate_type, only: [:create, :update]


	def index
		
		render json: User.all, each_serialize: UserSerializer
	end
	def show
		render json: User.find(params[:id])
	end
	
	def create
		user = User.new(user_params)
	if user.save
	      render json: user, status: 200
	    else
	      render json: { errors: user.errors }, status: 422
	    end
	end

	def update
    user = User.find(params[:id]) 

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
  	user = User.find(params[:id]) 
    user.destroy
    head 204
  end

   def update
    user = User.find(params[:id]) 

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

	private 
	def user_params
		ActiveModelSerializers::Deserialization.jsonapi_parse(params)
	end


end
