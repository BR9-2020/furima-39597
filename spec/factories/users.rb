FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.email}
    last_name             {Faker::Name.last_name}
    first_name            {Faker::Name.first_name}

    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end