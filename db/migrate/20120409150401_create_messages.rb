class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :event_id
      t.string :user_name

      t.timestamps
    end
  end
end
