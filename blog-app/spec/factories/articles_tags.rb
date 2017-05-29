# == Schema Information
#
# Table name: articles_tags
#
#  id         :integer          not null, primary key
#  article_id :integer
#  tag_id     :integer
#
# Indexes
#
#  fk_rails_74380b8667  (article_id)
#  fk_rails_d3e30c5d45  (tag_id)
#

FactoryGirl.define do
  factory :articles_tag do
    tag nil
    article nil
  end
end
