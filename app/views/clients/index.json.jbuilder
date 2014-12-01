json.array!(@clients) do |client|
  json.extract! client, :id, :phone_number, :name, :address
  json.url client_url(client, format: :json)
end
