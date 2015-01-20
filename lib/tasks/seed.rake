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

  desc "Seeds DB with consultation questions"
  task consultations: :environment do
    {
      "Country" => "What country do you live in?",
      "Confirmed preganancy" => "Have you confirmed you are pregnant?",
      "Encourage confirmation" => "You can confirm pregnancy by taking a pregnancy test or having an ultrasound.  Confirm your pregnancy.  If you have a positive result and you want an abortion with pills, you can count on safe2choose for a safe procedure.",
      "Last period date" => "Confirm the first day of your last normal period",
      "Unwanted pregnancy" => "Do you have an unwanted pregnancy?",
      "Confirm termination" => "Are you sure you want to terminate this pregnancy?",
      "Uncertain termination" => "If you are facing an unwanted pregnancy, remember you have three options to think about:  parenting, adoption and abortion.   Only you can decide, but you may find useful to talk about these choices with your partner, a close friend or a family member. If you are not ready to decide, you can consult our FAQs to learn about other alternatives.",
      "Know side effects" => "Have you been informed about the efficacy, side effects and risks of using abortion pills?",
      "Encourage research" => "At safe2choose we are committed to provide safe methods to have an abortion. It is important you learn about the abortion pills so you can make an informed decision.  Please visit this link and come back later to the online consultation",
      "IUD awareness" => "If you have an IUD in place, are you aware you must remove it before taking the pills?",
      "Other illnesses" => "Do you have any of the following illnesses:  known allergies, chronic adrenal failure, hemorrhagic disorder (bleeding disease), anemia, or inherited Porphyrias.",
      "STDs" => "o you have a history of or presence of any sexually transmitted disease?",
      "Attempted abortion" => "Have you already attempted to terminate this pregnancy using a different method?",
      "Bleeding" => "Are you bleeding?",
      "Other info" => "Would you like our doctor to be aware of any other relevant information about your health?  (e.g. medications you are currently taking;  previous history of ectopic pregnancy, etc.)"
    }.each do |preview, question|
      ConsultationQuestion.create!(preview: preview, question: question)
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
