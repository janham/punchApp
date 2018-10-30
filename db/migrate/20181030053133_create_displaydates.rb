class CreateDisplaydates < ActiveRecord::Migration[5.1]
  def change
    create_table :displaydates do |t|
      t.date :list_date
      t.timestamps
    end
  end
end
