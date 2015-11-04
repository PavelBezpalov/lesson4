require 'rails_helper'

describe 'Logging In' do
  it 'logs the user in and goes to the posts' do
    User.create(name: 'Pavel',
                email: 'pavel.bezpalov@cyber-wizard.com',
                password: '12345678',
                password_confirmation: '12345678')
    visit new_session_path
    fill_in 'Email Address', with: 'pavel.bezpalov@cyber-wizard.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log In'

    expect(page).to have_content('Posts')
    expect(page).to have_content('Your successfully logging in!')
  end

  it 'displays the email address in the event of a failed login' do
    visit new_session_path
    fill_in 'Email Address', with: 'pavel.bezpalov@cyber-wizard.com'
    fill_in 'Password', with: 'incorrect'
    click_button 'Log In'

    expect(page).to have_content('Please check your email and password.')
    expect(page).to have_field('Email Address', with: 'pavel.bezpalov@cyber-wizard.com')
  end
end