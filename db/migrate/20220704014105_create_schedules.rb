class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :acquaintance, null: false, foreign_key: true
      t.references :event,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
