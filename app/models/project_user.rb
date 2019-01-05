class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project
  enum designation: [:PM,:DEV]
end
