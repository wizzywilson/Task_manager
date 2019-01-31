# require 'rails_helper'
#
# RSpec.describe 'Home', type: :request do
#   it 'creates a task' do
#     headers = {
#       'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
#       'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
#     }
#     post '/create_project_user_task', { widget: { name: 'My Widget' } }, headers
#
#     expect(response.content_type).to eq('application/json')
#     expect(response).to have_http_status(:created)
#   end
#
# end
#
#
#
# "project_user":{"user_id": "3","task": {"name": "dfgdfgsdfg", "status": "Not_Started", "start_date"=>"01/15/2019", "end_date"=>"01/26/2019"}
