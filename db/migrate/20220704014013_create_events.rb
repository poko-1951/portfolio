class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title,    null: false
      t.string :content,  null: false, default: "未設定"
      t.string :place,    null: false, default: "未設定"
      t.datetime :start,  null: false
      t.datetime :end,    null: false

      t.timestamps
    end
  end
end
