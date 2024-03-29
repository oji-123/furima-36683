FactoryBot.define do
  factory :item do
    item_name           { Faker::Name.initials(number: 3) }
    item_explanation    { Faker::Lorem.sentence }
    price               { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id         { Faker::Number.between(from: 2,   to: 11) }
    status_id           { Faker::Number.between(from: 2,   to: 7) }
    shippingfee_id      { Faker::Number.between(from: 2,   to: 3) }
    prefecture_id       { Faker::Number.between(from: 2,   to: 48) }
    daystoship_id       { Faker::Number.between(from: 2,   to: 4) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
