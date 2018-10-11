class AddCulumnToPunches < ActiveRecord::Migration[5.1]
  def change
    add_column :punches, :punch_at_in, :datetime
    add_column :punches, :punch_at_out, :datetime
  end
end
