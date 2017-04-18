FactoryGirl.define do
  factory :idea do
    association :user, factory: :user

    sequence(:title) {|n| "#{Faker::Commerce.product_name} #{n}"  }
    body { Faker::Hipster.paragraph }

  end
end
