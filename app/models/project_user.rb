class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }
  belongs_to :assigner, class_name: 'User', foreign_key: 'assigned_by'
  enum designation: [:PM,:DEV]
  # belongs_to :user, :class_name => "User"
end
