# frozen_string_literal: true

# User
class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :project_user
  enum status: %I[Not_Started In_Progress Done]
  scope :order_by_date, -> { order(created_at: :asc) }
  has_many :comments
  # validate :date_validation


  def date_validation
    return if start_date.nil? && end_date.nil?
    debugger
    if start_date && end_date
      errors.add(:date, I18n.t('error.date.range')) if start_date > end_date
    end
  end

  private


  def future_date_check(date, date_type)
    errors.add(date_type, I18n.t('error.date.future')) if date < Date.today
  end
end
