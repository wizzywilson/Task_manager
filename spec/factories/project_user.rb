# frozen_string_literal: true

FactoryBot.define do
  factory :project_user do
    association :user, role: :employee
    project
    association :assigner, factory: :user

    trait :PM do
      designation :PM
    end

    trait :DEV do
      designation :DEV
    end
  end
end
