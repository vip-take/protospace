include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    trait :main do
      photo { fixture_file_upload "spec/files/img/m1.png"}
      role 0
    end

    trait :sub do
      photo { fixture_file_upload "spec/files/img/s1.png"}
      role 1
    end

    trait :main_ico do
      photo { fixture_file_upload "spec/files/img/m2.ico"}
      role 0
    end
  end
end
