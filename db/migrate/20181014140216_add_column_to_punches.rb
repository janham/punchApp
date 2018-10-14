class AddColumnToPunches < ActiveRecord::Migration[5.1]
  def change
    add_column :punches, :punch_date, :date
  end
end
