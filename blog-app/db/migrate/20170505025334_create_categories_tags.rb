class CreateCategoriesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_tags do |t|
      t.integer :category_id
      t.integer :tag_id
    end

    add_foreign_key :categories_tags, :categories
    add_foreign_key :categories_tags, :tags

  end
end
