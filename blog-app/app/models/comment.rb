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
  
  # Check final comment of current user that author checked yet?
# => Have 2 options:
# =>  - opt1: this comment have notification, check this notification author checked?
# =>  - opt2: this comment haven't notification because this this author  not yet check comment before that
  def self.author_checked_before_notification current_user, article
    comment_for_article_to_current_user = Comment.where(user_id: current_user.id, article_id: article.id)
    return true if comment_for_article_to_current_user.blank?
    comment_for_article_to_current_user.each do |comment|
      comment.notifications.each do |notification|
        return false if notification.isChecked == false
      end
    end
    return true
  end
end

