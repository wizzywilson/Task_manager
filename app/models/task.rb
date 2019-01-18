class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :project_user
  enum status: %I[Not_Started In_Progress Done]
end
