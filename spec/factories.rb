FactoryGirl.define do
  factory :user do
    name 'Pavel'
    sequence(:email) { |n| "pavel.bezpalov#{n}@cyber-wizard.com" }
    password '12345678'
    password_confirmation '12345678'
  end
end