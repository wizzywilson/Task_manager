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
  
end
