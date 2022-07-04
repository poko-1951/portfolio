class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.references :acquaintance             , foreign_key: true #知人に紐付けない（不特定多数）の場合を設けるためにnullを許容する
      t.references :user,         null: false, foreign_key: true
      t.references :topic,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
