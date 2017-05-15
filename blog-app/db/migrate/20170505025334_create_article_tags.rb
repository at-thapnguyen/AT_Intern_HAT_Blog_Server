class CreateArticleTags < ActiveRecord::Migration[5.0]
  def change
    create_table :article_tags do |t|
      t.integer :article_id
      t.integer :tag_id
    end

    add_foreign_key :article_tags, :articles
    add_foreign_key :article_tags, :tags

  end
end
