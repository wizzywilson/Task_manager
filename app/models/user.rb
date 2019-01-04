class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  enum role: [:admin, :employee]
  before_validation :generate_password, on: :create
  after_save :send_password

  private

  def generate_password
    generated_password = Devise.friendly_token.first(8)
    p generated_password
    p '-----------------------'
    self.password = generated_password
    # RegistrationMailer.welcome(user, generated_password).deliver

  end

  def send_password
    UserMailer.welcome(self,self.password).deliver
  end

end
