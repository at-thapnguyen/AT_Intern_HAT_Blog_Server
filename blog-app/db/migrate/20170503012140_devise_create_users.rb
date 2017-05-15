class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|

      ## My design
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :access_token
      t.string :confirm_token
      t.date :birthday
      t.boolean :access
      t.boolean :blocked
      t.boolean :access, default: false
      t.boolean :blocked, default: false
      t.boolean :email_confirmed, default: false
    end
  end
end
