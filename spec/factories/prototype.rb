include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :prototype do
    title { Faker::Commerce.product_name }
    catchcopy { Faker::Lorem.word }
    concept { Faker::Lorem.sentence}
  end

  trait :with_main_sub do
    after(:build) do |prototype|
        prototype.images << FactoryGirl.build(:image, :main)
        prototype.images << FactoryGirl.build(:image, :sub)
    end
  end

  trait :with_sub do
    after(:build) do |prototype|
        prototype.images << FactoryGirl.build(:image)
        prototype.images << FactoryGirl.build(:image, :sub)
    end
  end

  trait :with_main_value_main do
    after(:build) do |prototype|
        prototype.images << FactoryGirl.build(:image_default_main)
    end
  end

  trait :with_tags do
    after(:build) do |prototype|
        prototype.tag_list = '"T1","T2","T3"'
    end
  end

  factory :like, class: Like do
  end

  factory :comment, class: Comment do
    text { Faker::Lorem.sentence}
  end


end
