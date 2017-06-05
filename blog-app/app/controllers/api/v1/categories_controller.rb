class Api::V1::CategoriesController < BaseController
  before_action :authentication!, only: [:create, :update, :destroy]

  def index
    render json: Category.all
  end

  def create
    if current_user.present?
      if current_user.access
        category = Category.create name: params[:category][:name]
        if category.valid?
          render json: { status: 200 }
        else
          render json: { errors: [ status: 400, message: [ category.errors.messages ]]}
        end
      else
        render json: auth_error
      end
    else
      render json: auth_error
    end
  end

  def update
    if current_user.present?
      if current_user.access
        category = Category.find params[:id]
        category.name = params[:category][:name]
        if category.save
          render json: { status: 200 }
        else
          render json: { errors: [ status: 400, message: [ category.errors.messages ]]}
        end
      else
        render json: auth_error
      end
    else
      render json: auth_error
    end
  end

  def destroy
    if current_user.present?
      if current_user.access
        category = Category.find params[:id]
        category.deleted = true
        if category.save
          render json: { status: 200 }
        else
          render json: { errors: [ status: 400, message: [ category.errors.messages ]]}
        end
      else
        render json: auth_error
      end
    else
      render json: auth_error
    end
  end

end
