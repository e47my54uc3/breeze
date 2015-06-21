class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type
      t.integer :amount
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
