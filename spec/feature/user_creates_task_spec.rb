require 'rails_helper'
feature 'PM creates Task' do
  scenario 'successfully' do
    sign_in

    click_on('My Tasks')
    expect(page).to have_css 'a span', text: ' My Tasks'
  end
end
