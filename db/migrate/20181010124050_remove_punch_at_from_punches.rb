class RemovePunchAtFromPunches < ActiveRecord::Migration[5.1]
  def change
    remove_column :punches, :punch_at, :datetime
  end
end
