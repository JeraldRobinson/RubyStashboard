FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    
    factory :admin, :class => User do
      name 'Admin User'
      sequence(:email) { |n| "admin#{n}@rubystash.com"}
      password "password"
      admin true
    end
  end
   
  factory :status do
    name "up"
    image "icons/fugue/tick-circle.png"
  end
  
  factory :service do
    sequence(:name)  { |n| "Service #{n}" }
    user
    description "Lorem ipsum"
    url "http://www.example.com/"
  end
  
  factory :event do
    sequence(:message) {|n| "Event #{n}"}
    service
    status
  end
end