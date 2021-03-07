# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    first_name { Faker::Lorem.characters(20) }
    last_name { Faker::Lorem.characters(20) }
    show_name { Faker::Lorem.characters(20) }
  end
end
