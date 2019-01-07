class ApplicationController < ActionController::Base

  # # Setting path to instruct where to redirect itself after loging in
  # def after_sign_in_path_for(resource)
  #   debugger
  #   stored_location_for(resource)
  #     if resource.is_a?(User)
  #       resource.admin? ? admin_root_url : root_url
  #     end
  # end

def authenticate_current_user!



  if current_user.nil?
    p '-------------------------'
    p 'inside nill'
     if request.original_fullpath == admin_root_path
       redirect_to new_user_session_path
     else
       redirect_to sign_in_path
     end
    p '-------------------------'

    # authenticate_user
  else
    if request.referer == new_user_session_path
      if current_user.employee?
        sign_out current_user
      end
    end
    if current_user.admin?
      redirect_to admin_root_path
      p '-------------------------'
      p 'inside admin'
      p '-------------------------'
    elsif current_user.employee?
      p '-------------------------'
      p 'inside employee'
      p '-------------------------'
      redirect_to root_path
    end
  end
end

end
