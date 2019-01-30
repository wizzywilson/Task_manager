# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  # Authenticates and directs user upon using devise and active admin
  # this method is the overriden version of authenticate_user!
  def authenticate_current_user!
    if current_user.nil?
      if request.original_fullpath == admin_root_path
        redirect_to new_user_session_path
      else
        redirect_to sign_in_path
      end
    elsif current_user.admin?
      redirect_to admin_root_path if request.original_fullpath == root_path
    elsif current_user.employee?
      redirect_to root_path if request.original_fullpath == admin_root_path
    end
  end
end
