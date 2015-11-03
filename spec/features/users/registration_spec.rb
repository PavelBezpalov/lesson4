require 'rails_helper'

describe 'Signing up' do
  it 'allow a user to sign up' do
    expect(User.count).to eq(0)

    visit '/'
    expect(page).to have_content('Sign Up')
    click_link 'Sign Up'

    fill_in 'Name', with: 'Pavel'
    fill_in 'Email', with: 'pavel.bezpalov@cyber-wizard.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password Confirmation', with: '12345678'
    click_button 'Sign Up'

    expect(User.count).to eq(1)
  end

end