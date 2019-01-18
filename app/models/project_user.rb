class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :tasks
  accepts_nested_attributes_for :tasks
  validates :user_id, uniqueness: { scope: :project_id }
  belongs_to :assigner, class_name: 'User', foreign_key: 'assigned_by'
  enum designation: [:PM,:DEV]
  # belongs_to :user, :class_name => "User"
  scope :particular_project_user,->(user_id,project_id) { find_by(user_id: user_id, project_id: project_id) }

end
