class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :notificationable_id
      t.string :notificationable_type
      t.integer :user_id
      t.string :message
      t.string :image
      t.boolean :isChecked, default: 0
      t.timestamps
    end
  end
end
