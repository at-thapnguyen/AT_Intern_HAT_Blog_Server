class CreateArticlesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :articles_tags do |t|
      t.integer :article_id
      t.integer :tag_id
    end

    add_foreign_key :articles_tags, :articles
    add_foreign_key :articles_tags, :tags

  end
end
