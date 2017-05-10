class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|

      ## My design
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password
      t.date :birthday
      t.boolean :access
      t.boolean :blocked
    end
  end
end
