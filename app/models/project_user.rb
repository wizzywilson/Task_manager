# frozen_string_literal: true

# This is a join Model between User and Project
# It Stores the role of a particular User in a specific Project
class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :tasks
  accepts_nested_attributes_for :tasks
  validates :user_id, uniqueness: { scope: :project_id }
  belongs_to :assigner, class_name: 'User', foreign_key: 'assigned_by'
  enum designation: %I[PM DEV]
  scope :get_project_user, lambda { |user_id, project_id|
    find_by(user_id: user_id, project_id: project_id)
  }
end
