# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  types      :boolean          default("1")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

class Attention < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :article_id, presence: true
  validates :user_id, presence: true
  has_many :notifications, as: :notificationable, dependent: :destroy
end
