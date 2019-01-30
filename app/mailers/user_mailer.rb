# frozen_string_literal: true

# UserMailer
class UserMailer < ApplicationMailer
  default from: 'wilson@qburst.com'

  def welcome(user)
    @user = user
    @password = user.password
    mail(to: @user.email)
  end
end
