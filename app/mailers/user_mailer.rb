class UserMailer < ApplicationMailer
  default from: 'wilson@qburst.com'

  def welcome(user,password)
    @user = user
    @password = password
    mail(to: @user.email)
  end



end
