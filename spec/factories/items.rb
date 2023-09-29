FactoryBot.define do
  factory :item do
    item_name          { Faker::Vehicle.manufacture }
    item_description   { Faker::Vehicle.version }
    category_id        { Faker::Number.between(from: 2, to: 11) }
    condition_id       { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_id   { Faker::Number.between(from: 2, to: 3) }
    shipping_region_id { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id    { Faker::Number.between(from: 2, to: 4) }
    price              { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/f1_car.png'), filename: 'f1_car.png')
    end
  end
end
