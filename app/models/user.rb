# frozen_string_literal: true

# User
class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  enum role: %I[admin employee]
  has_many :comments
  before_validation :generate_password, on: :create
  after_create :send_password, on: :create

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_one_attached :profile_picture

  private

  # For Generating Random password
  def generate_password
    generated_password = Devise.friendly_token.first(8)
    p generated_password
    self.password = generated_password
  end

  # For Sending a request to Usermailer's welcome method
  def send_password
    UserMailer.welcome(self).deliver
  end
end
