# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  fk_rails_03de2dc08c  (user_id)
#  fk_rails_3bf61a60d3  (article_id)
#

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :content, presence: true
  has_many :notifications, as: :notificationable, dependent: :destroy
  
 
end

