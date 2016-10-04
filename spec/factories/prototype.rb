include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :prototype do
    title { Faker::Commerce.product_name }
    catchcopy { Faker::Lorem.word }
    concept { Faker::Lorem.sentence}
  end

  trait :with_main_sub do
    after(:build) do |prototype|
        prototype.images << FactoryGirl.build(:image, :main, prototype_id: prototype.id)
        prototype.images << FactoryGirl.build(:image, :sub)
    end
  end

  trait :with_sub do
    after(:build) do |prototype|
        prototype.images << FactoryGirl.build(:image)
        prototype.images << FactoryGirl.build(:image, :sub)
    end
  end

  factory :like, class: Like do
  end

  factory :comment, class: Comment do
    text { Faker::Lorem.sentence}
  end

end
