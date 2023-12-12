FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: 'gmail.com') }
    password { Faker::Internet.password(min_length: 8, special_characters: true) }
    password_confirmation { password } 
  end
end
