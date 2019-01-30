# frozen_string_literal: true

# Project
class Project < ApplicationRecord
  validates :name, uniqueness: true
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  accepts_nested_attributes_for :project_users, allow_destroy: true
end
