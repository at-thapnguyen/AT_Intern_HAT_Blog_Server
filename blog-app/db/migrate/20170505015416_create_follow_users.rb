class CreateFollowUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_users do |t|
      t.integer :user_id
      t.integer :be_followed_id
      t.boolean :isChecked, default: false
    end

    add_foreign_key :follow_users, :users

  end
end
