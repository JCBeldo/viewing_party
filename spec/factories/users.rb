FactoryBot.define do 
  factory :user do 
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'test' }
    password_confirmation { 'test' }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end