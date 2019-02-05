# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :request do
  it 'Deletes a task' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    task = create(:task, :Done)
    delete "/tasks/#{task.id}", headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(200)
  end

  it 'Task delete does not happen' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    delete '/tasks/100', headers: headers

    expect(response.content_type).to eq('application/json')
    json_response = JSON.parse(response.body)
    expect(json_response['status']).to eql(400)
  end

  it 'Show task' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    task = create(:task, :Done)
    get "/tasks/#{task.id}", headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(200)
  end

  it 'Show task error' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    get '/tasks/100', headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(400)
  end

  it 'Update task when project_user exist' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    task = create(:task, :Done)
    sign_in task.project_user.assigner
    patch "/tasks/#{task.id}", :params => { project_user: { user_id: task.project_user.id, task: { name: "wilson",
      status: task.status, start_date: task.start_date, end_date: task.end_date }},
      project: task.project_user.project.id, id: task.id }, headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(200)
  end

  it 'Update task when project_user doesnt exist exist' do
    headers = {
      'ACCEPT' => 'application/json',     # This is what Rails 4 accepts
      'HTTP_ACCEPT' => 'application/json' # This is what Rails 3 accepts
    }
    task = create(:task, :Done)
    user = create(:user, :employee)
    task.project_user.user = user
    sign_in task.project_user.assigner
    patch "/tasks/#{task.id}", :params => { project_user: { user_id: task.project_user.id, task: { name: "wilson",
      status: task.status, start_date: task.start_date, end_date: task.end_date }},
      project: task.project_user.project.id, id: task.id }, headers: headers
    json_response = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json')
    expect(json_response['status']).to eql(200)
  end

end

# "project_user": {"user_id": "3", "task"=>{"name"=>"fghfghu", "status"=>"Not_Started",
#    "start_date"=>"", "end_date"=>"2019-01-01"}},
#  "project"=>"1", "controller"=>"tasks", "action"=>"update", "id"=>"5"

RSpec.describe "Sessions" do
  it "signs user in and out" do
    user = create(:user)    ## uncomment if using FactoryBot
    # user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password") ## uncomment if not using FactoryBot
    sign_in user
    get root_path
    expect(response).to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.

    sign_out user
    get root_path
    expect(response).not_to render_template(:index) # add gem 'rails-controller-testing' to your Gemfile first.
  end
end
