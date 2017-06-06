class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :image, :isChecked
  def count_notification
  Notification.all.where(isChecked: 1).size
  end
  
end