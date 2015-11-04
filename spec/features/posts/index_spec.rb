require 'rails_helper'

describe 'Listings posts' do
  it 'requires login' do
    visit '/posts'
    expect(page).to have_content('You must be logged in')
  end
end