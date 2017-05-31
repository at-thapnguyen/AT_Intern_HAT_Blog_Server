# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  isLiked    :boolean          default("0")
#  isFollowed :boolean          default("0")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

class Follow < Attention
end
