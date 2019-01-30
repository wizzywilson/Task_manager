require 'rails_helper'

feature 'User visits homepage' do
  scenario 'successfully' do
    visit sign_in_path

    expect(page).to have_css 'a', text: 'Forgot your password?'
  end
end
