class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :image, :isChecked
end