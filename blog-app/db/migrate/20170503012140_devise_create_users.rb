class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :username
      t.string :email
      t.string :avatar 
      t.string :description
      t.string :password_digest
      t.string :access_token
      t.string :confirm_token
      t.date :birthday
      t.boolean :access
      t.boolean :blocked
      t.boolean :access, default: false
      t.boolean :blocked, default: true
      t.boolean :email_confirmed, default: false
      t.timestamps
    end
  end
end

