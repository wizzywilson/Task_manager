class User < ApplicationRecord

  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  enum role: %I[admin employee]
  before_validation :generate_password, on: :create
  after_create :send_password, on: :create

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  # has_many :project_users, :foreign_key => "user", :class_name => "ProjectUser"

  mount_uploader :image, ImageUploader


  validate :image_size_validation
   
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end

  private

  # For Generating Random password
  def generate_password
    generated_password = Devise.friendly_token.first(8)
    p generated_password
    p '--------------------------------------------------------'
    self.password = generated_password
    p '--------------------------------------------------------'
  end

  #For Sending a request to Usermailer's welcome method
  def send_password
    UserMailer.welcome(self,self.password).deliver
  end

end
