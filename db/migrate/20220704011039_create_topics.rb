class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title   , null: false
      t.string :content , null: false

      t.timestamps
    end
  end
end
