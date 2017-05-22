class CreateAttentions < ActiveRecord::Migration[5.0]
  def change
    create_table :attentions do |t|
      t.integer :article_id
      t.integer :user_id
      t.boolean :types, default: 1
    end
    add_foreign_key :attentions, :articles
  end
end
