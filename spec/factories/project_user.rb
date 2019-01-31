# frozen_string_literal: true

FactoryBot.define do
  factory :project_user do
    user
    project
    association :assigner, factory: :user, role: :admin

    trait :PM do
      designation :PM
    end

    trait :DEV do
      designation :DEV
    end
  end
end
