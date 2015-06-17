class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :event_id
      t.text :action
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
  end
end
