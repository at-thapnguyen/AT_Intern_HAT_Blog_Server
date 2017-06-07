# == Schema Information
#
# Table name: notifications
#
#  id                    :integer          not null, primary key
#  notificationable_id   :integer
#  notificationable_type :string(255)
#  user_id               :integer
#  message               :string(255)
#  image                 :string(255)
#  isChecked             :boolean          default("0")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :notificationable, polymorphic: true
  
end
