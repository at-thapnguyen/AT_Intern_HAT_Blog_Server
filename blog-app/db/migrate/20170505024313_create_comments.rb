class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_id
      t.text :content
      
      t.timestamps
    end

    add_foreign_key :comments, :users
    add_foreign_key :comments, :articles
  end
end
