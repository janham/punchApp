class CreatePunches < ActiveRecord::Migration[5.1]
  def change
    create_table :punches do |t|
      t.integer :user_id
      t.datetime :punch_at
      t.string :status

      t.timestamps
    end
    add_index :punches, :user_id
  end
end
