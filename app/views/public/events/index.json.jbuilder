#controllerに追加した@eventsから情報を配列化する
json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.start event.start_at
  json.end event.end_at
  json.url event_url(event.id) #詳細画面に遷移させるためにリンクを持たせる
end

# json.〇〇：送るデータの型
# event.〇〇：対応するモデルのカラム