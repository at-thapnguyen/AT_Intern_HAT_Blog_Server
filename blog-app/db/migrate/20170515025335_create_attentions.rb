class CreateAttentions < ActiveRecord::Migration[5.0]
  def change
    create_table :attentions do |t|
      t.integer :article_id
      t.integer :user_id
      t.boolean :isLiked, default: 0
      t.boolean :isFollowed, default: 0
    end

    add_foreign_key :attentions, :articles

  end
end
