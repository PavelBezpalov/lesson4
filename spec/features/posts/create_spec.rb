require 'rails_helper'

describe 'Creating posts' do
  def create_post_item(options={})
    options[:title] ||= 'First post'
    options[:body] ||= 'Body of the first post'

    visit '/'
    click_link 'New Post'
    expect(page).to have_content('New Post')

    fill_in 'Title', with: options[:title]
    fill_in 'Body', with: options[:body]
    click_button 'Create Post'
  end

  it 'redirects to the post index page on success' do
    create_post_item

    expect(page).to have_content('First post')
  end

  it 'displays an error when the post has no title' do
    create_post_item title: ''

    expect(page).to have_content('error')
  end

  it 'displays an error when the post has no body' do
    create_post_item body: ''

    expect(page).to have_content('error')
  end

  it 'displays an error when the post has a title with length less than 5
characters' do
    create_post_item title: 'A' * 4

    expect(page).to have_content('error')
  end

  it 'displays an error when the post has a title with length more than 100
characters' do
    create_post_item title: 'A' * 101

    expect(page).to have_content('error')
  end

  it 'displays an error when the post has the same title as existing post' do
    create_post_item

    expect(page).to have_content('First post')

    create_post_item

    expect(page).to have_content('error')
  end
end