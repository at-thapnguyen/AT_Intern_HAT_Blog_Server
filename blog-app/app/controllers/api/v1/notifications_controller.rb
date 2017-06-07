class Api::V1::NotificationsController < BaseController
	before_action :authentication! , only: [:index,:update]
	def index
		render json: Notification.where(user_id: current_user.id).order(created_at: :desc)
	end
	def update
		notification = Notification.find(params[:id])
		notification.update_columns(isChecked: 1) 
		render json: Notification.where(user_id: current_user.id)
	end
end
