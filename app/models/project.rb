class Project < ApplicationRecord

validates :name, uniqueness: true
  has_many :project_users,dependent: :destroy
  has_many :users, through: :project_users
  # has_many :task,dependent: :destroy
  # validates :name, uniqueness: { message: "Please select a unique name" }
  accepts_nested_attributes_for :project_users, allow_destroy: true

end
