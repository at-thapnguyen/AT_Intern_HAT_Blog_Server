class Api::V1::NotificationsController < BaseController
	before_action :authentication! , only: [:index,:update]
	def index
		render json: Notification.where(user_id: current_user.id)
	end

	# def update
	# 	if params[:isChecked].to_i == 0
	# 	 current_user.notifications.update_all(isChecked: 1)
	# 	 render json: Notification.where(user_id: current_user.id)
	# 	end
	# end
	def update
		notification = Notification.find(params[:id])
		notification.update_columns(isChecked: 1) 
		render json: Notification.where(user_id: current_user.id)
	end
end
