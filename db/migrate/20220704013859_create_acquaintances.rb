class CreateAcquaintances < ActiveRecord::Migration[6.1]
  def change
    create_table :acquaintances do |t|
      t.references :user,     null: false, foreign_key: true
      t.string :name,         null: false
      t.string :relationship, null: false, default: "未設定"
      t.string :character,    null: false, default: "未設定"
      t.string :like,         null: false, default: "未設定"

      t.timestamps
    end
  end
end
