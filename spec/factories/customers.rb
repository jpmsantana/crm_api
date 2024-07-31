# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
  end
end
