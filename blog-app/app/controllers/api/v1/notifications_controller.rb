class Api::V1::NotificationsController < BaseController
  before_action :authentication! , only: [:index,:update]
  def index
    render json: Notification.where(user_id: current_user.id).order(created_at: :desc)
  end

  def update
    notification = Notification.find(params[:id])
    binding.pry
    notification.update_columns(isChecked: 1)
    @current_user.update_columns count_notifications: @current_user.count_notifications - 1 if @current_user.count_notifications > 0
    render json: Notification.where(user_id: current_user.id)
  end
end
  