class Api::V1::NotificationsController < ApplicationController
  def show
    render json: Notification.where(user_id: params[:id])
  end
end
