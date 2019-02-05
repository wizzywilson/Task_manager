require 'rails_helper'

RSpec.describe 'Home', type: :request do
  it 'Creates a task' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    task = build(:task, :Done)
    sign_in task.project_user.assigner
    post '/create_project_user_task', params: { project_user: { user_id: task.project_user.id, task: { name: task.name,
      status: task.status, start_date: task.start_date, end_date: task.end_date }},
      project: task.project_user.project.id, id: task.id }, headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(200)
  end
end
