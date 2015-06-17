class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :key
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
