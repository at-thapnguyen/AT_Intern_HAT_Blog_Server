class CreateCategorys < ActiveRecord::Migration[5.0]
  def change
    create_table :categorys do |t|
      t.string :name
      t.boolean :deleted
    end
  end
end
