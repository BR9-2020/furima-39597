FactoryBot.define do
  factory :purchase_shipment do
    postcode { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) }
    shipping_region_id { Faker::Number.between(from: 2, to: 48) }
    city_town_village { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number { Faker::Number.decimal_part(digits: 11) }
    user_id { Faker::Number.non_zero_digit }
    item_id { Faker::Number.non_zero_digit }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
