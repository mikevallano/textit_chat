json.array!(@messages) do |message|
  json.extract! message, :id, :from, :to, :message, :sent_at, :sent, :delivered
  json.url message_url(message, format: :json)
end
