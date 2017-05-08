class CreateAttentions < ActiveRecord::Migration[5.0]
  def change
    create_table :attentions do |t|
      t.integer :article_id
      t.integer :user_id
      t.boolean :isLiked
      t.boolean :isFollowed
      t.boolean :notification_like
      t.boolean :notification_follow
    end

    add_foreign_key :attentions, :users
    add_foreign_key :attentions, :articles
  end
end
