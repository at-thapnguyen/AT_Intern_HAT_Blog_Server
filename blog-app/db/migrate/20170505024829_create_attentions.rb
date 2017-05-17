class CreateAttentions < ActiveRecord::Migration[5.0]
  def change
    create_table :attentions do |t|
      t.integer :article_id
      t.integer :user_id
      t.boolean :isLiked, default: false
      t.boolean :isFollowed, default: false
      t.boolean :notification_like, default: false
      t.boolean :notification_follow, default: false
    end

    add_foreign_key :attentions, :users
    add_foreign_key :attentions, :articles
  end
end
