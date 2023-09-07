FactoryBot.define do
  factory :user do
    nickname                   {'test'}
    email                      {'test@example'}
    password                   {'000000a'}
    password_confirmation      {password}
  end
end