FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password "123456"
    password_confirmation "123456"
    group { Faker::Company.suffix }
    profile { Faker::Lorem.sentence }
    works { Faker::Company.name }
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
  end

end
