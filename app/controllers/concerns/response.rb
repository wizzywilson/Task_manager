module Response
  include ActiveSupport::Concern

  def json_response(json)
    respond_to do |format|
      format.js
      format.json { render json: json }
    end
  end
end
