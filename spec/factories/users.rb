FactoryBot.define do
  factory :user do
    name { "user" }
    email { "test@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end