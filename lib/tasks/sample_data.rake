namespace :db do
  
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    
    Status.create!(name: "up", 
                   description: "The service is up",
                   image: "icons/fugue/tick-circle.png")
    
    Status.create!(name: "warning",
                   description: "The service is experiencing intermittent problems",
                   image: "icons/fugue/exclamation.png")
    
    Status.create!(name: "maintenance",
                               description: "Doing scheduled maintenance",
                               image: "icons/fugue/clock.png")
    
    Status.create!(name: "down", 
                      description: "The service is currently down",
                      image: "icons/fugue/cross-circle.png")
    
    def random_status
      return rand(4) + 1
    end
    
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    User.create!(name: "Example User",
                 email: "examplezzz@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    
    puts "*"*5 + "CREATING 99 USERS" + "*"*5
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    puts "*"*5 + "CREATING SERVICES FOR 6 USERS" + "*"*5
    users=User.all(limit: 6)
    2.times do |n|
      service_count = " #{n+1}"
      service_description = Faker::Lorem.words(6)
      service_url = "www.example.com/service#{n+1}"
      
      users.each {|user| user.services.create!(name: "Service for "+user.name[0,4]+service_count, 
                                               description: service_description, 
                                               url: service_url)}
      services=Array.new
      users.each do |user|
        user.services.each do |service|
          services.push(service)
        end
      end
      
      puts "*"*5 + "CREATING EVENTS" + "*"*5
      3.times do |n|
        event_message=Faker::Lorem.words(1)
        event_created_at=Date.today-n.days
        
        puts "*"*5 + "ASSIGNING RANDOM STATUS TO EVENTS" + "*"*5
        services.each do |service|
          event=service.events.new( { message: event_message } )
          event.status = Status.find(random_status)
          event.created_at = event_created_at
          event.save
        end
      end
    end        
  end
end