class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  belongs_to :assigner, class_name: 'User', foreign_key: 'assigned_by'
  enum designation: [:PM,:DEV]
  # belongs_to :user, :class_name => "User"
end
