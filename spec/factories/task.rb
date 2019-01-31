# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    project_user
    name { Faker::Name.name }
    start_date { Faker::Date.forward(10) }
    end_date { Faker::Date.forward(20) }

    trait :Not_Started do
      status :Not_Started
    end

    trait :In_Progress do
      status :In_Progress
    end

    trait :Done do
      status :Done
    end
  end
end
