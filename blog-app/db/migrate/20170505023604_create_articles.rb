class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :title_image
      t.integer :user_id
      t.integer :category_id
      t.integer :count_like, default: 0
      t.timestamps
      t.boolean :deleted
    end

    add_foreign_key :articles, :users
    add_foreign_key :articles, :categories

  end
end
