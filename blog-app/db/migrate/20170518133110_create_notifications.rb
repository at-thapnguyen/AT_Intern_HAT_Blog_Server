class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :notificationable_id
      t.string :notificationable_type
      t.integer :user_id
      t.string :message
      t.boolean :isTrue
      t.boolean :isChecked, default: 1
    end
  end
end
