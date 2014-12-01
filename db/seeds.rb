# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

{
  "marvinmarnold@gmail.com" => "marvinsafe2choose",
  "rodrigo@dktinternational.org" => "rodrigosafe2choose"
}.each do |k, v|
  u = User.create!(email: k, password: v)
  20.times do
    from = rand(10000000000)
    client = Client.create!(phone_number: from)
    chat = u.chats.create!(client: client)


    #Create orders
    if rand < 0.5
      o = u.orders.create!(client: client, subtotal: 100, shipping: 10, taxes: 5)
    end

    # Create messages
    rand(20).times do
      if rand < 0.5
        chat.messages.create!(from: from, to: Message.system_sms_phone_number, message: Faker::Lorem.sentence, sent: true, sent_at: Time.zone.now)
      else
        chat.messages.create!(to: from, from: Message.system_sms_phone_number, message: Faker::Lorem.sentence, sent: true, sent_at: Time.zone.now)
      end
    end
  end
end