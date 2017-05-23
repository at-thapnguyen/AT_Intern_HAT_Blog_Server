# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  isLiked    :boolean
#  isFollowed :boolean
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

class Like < Attention
end
