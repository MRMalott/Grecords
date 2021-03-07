# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    title { Faker::Lorem.characters(20) }
    year { Faker::Number.between(1877, 2021) }
    condition { 0 }
    description { Faker::Lorem.characters(100) }
  end
end
