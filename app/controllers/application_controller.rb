class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    stored_location_for(resource)
      if resource.is_a?(User)
        resource.admin? ? admin_root_url : root_url
      end

  end


end
