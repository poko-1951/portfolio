class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :topic_id
      t.integer :comment_id
      t.string :action,      null: false, default: " "
      t.boolean :checked,    null: false, default: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :topic_id
    add_index :notifications, :comment_id
  end
end
