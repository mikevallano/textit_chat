namespace :seed do
  desc "Seeds DB with predefines FAQs"
  task faqs: :environment do
   faqs = YAML.load_file('lib/tasks/en.faq_seed.yml')
    faqs.each do |faq, details|
      Faq.create(details)
    end
  end

  desc "Seeds DB with predefined follow-up questions"
  task follows: :environment do
    followups = YAML.load_file('lib/tasks/en.follow_up_seed.yml')
    followups.each do |question, details|
      FollowUpQuestion.create(details)
    end
  end

  desc "Seeds DB with health problems"
  task health_problems: :environment do
    problems = YAML.load_file('lib/tasks/en.health_problem_seed.yml')
    problems.each do |problem, details|
      HealthProblem.create(details)
    end
  end

  desc "Seeds DB with consultation questions"
  task consultations: :environment do
    consultations = YAML.load_file('lib/tasks/en.consultation_seed.yml')
    consultations.each do |consult, details|
      ConsultationQuestion.create(details)
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
    users = YAML.load_file('lib/tasks/en.admin_seed.yml')
    users.each do |user, details|
      User.create(details)
    end
  end

  desc "Seed admins, FAQs, followups, health_problems, and consultation questions"
  task :all_but_chat_seed => [:faqs, :admins, :follows, :health_problems, :consultations]
end