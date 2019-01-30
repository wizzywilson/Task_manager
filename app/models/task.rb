# frozen_string_literal: true

# User
class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :project_user
  enum status: %I[Not_Started In_Progress Done]
  scope :order_by_date, -> { order(created_at: :asc) }
  validate :date_validation

  def date_validation
    start_date = string_to_date(self.start_date)
    end_date = string_to_date(self.end_date)
    future_date_check(start_date, :start_date)
    future_date_check(end_date, :end_date)

    if (start_date.is_a? Date) && (end_date.is_a? Date)
      errors.add(:date, I18n.t('error.date.range')) if start_date > end_date
    end
  end

  private

  def string_to_date(date)
    Date.strptime(date, "%m/%d/%Y") rescue ""
  end

  def future_date_check(date, date_type)
    errors.add(date_type, I18n.t('error.date.future')) if (date.is_a? Date) && (!date.future?)
  end
end
