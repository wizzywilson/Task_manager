class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :project_user
  enum status: %I[Not_Started In_Progress Done]

  validate :date_validation

    def date_validation

      start_date = Date.strptime(self.start_date, "%m/%d/%y")
      end_date = Date.strptime(self.end_date, "%m/%d/%y")

 if start_date > end_date
self.errors.add(:date,"Start date should be less than end date")
end
    end

end
