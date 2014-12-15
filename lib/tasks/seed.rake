namespace :seed do
  desc "Seeds DB with predefines FAQs"
  task faqs: :environment do
    {
      "What are abortion pills?" => "Abortion pills are prescribed tablets that can be used to induce an abortion during the first 9 weeks of pregnancy. The active ingredient in these pills is called Mifepristone and is sometimes taken with Misoprostol.",
      "Are all brands of mifepristone and misoprostol equally effective?" => "No. Some manufacturers and shipping conditions are known to make these drugs ineffective or harmful. Safe2Choose only uses the best suppliers and we use double-aluminum blister packs to ensure quality."
    }.each do |q, a|
      Faq.create!(question: q, answer: a)
    end
  end

  desc "Seeds DB with predefined follow-up questions"
  task follows: :environment do
    [
      "Where do you live?",
      "How old are you?"
    ].each do |q, a|
      FollowUpQuestion.create!(question: q)
    end
  end

  desc "Seeds DB with random users, chats, and orders"
  task users_chats_orders: :environment do
    {
      "marvinmarnold@gmail.com" => "marvinsafe2choose",
      "rodrigo@dktinternational.org" => "rodrigosafe2choose"
    }.each do |k, v|
      u = User.create!(email: k, password: v, is_admin: true)
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
  end

  desc "Seeds DB admins"
  task admins: :environment do
    {
      "marvinmarnold@gmail.com" => "marvinsafe2choose",
      "rodrigo@dktinternational.org" => "rodrigosafe2choose"
    }.each do |k, v|
      u = User.create!(email: k, password: v, is_admin: true)
    end
  end

end
