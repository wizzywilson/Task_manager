class Comment < ApplicationRecord
  validates :name, presence: true
  belongs_to :task
  belongs_to :user
end
