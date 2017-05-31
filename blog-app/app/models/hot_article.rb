# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text(65535)
#  title_image :string(255)
#  user_id     :integer
#  category_id :integer
#  count_like  :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean
#  slug        :string(255)
#
# Indexes
#
#  fk_rails_3d31dad1cc     (user_id)
#  fk_rails_af09d53ead     (category_id)
#  index_articles_on_slug  (slug)
#

class HotArticle < Article
end
