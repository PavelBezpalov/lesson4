require 'rails_helper'

describe 'Editing posts' do
  let!(:post) { Post.create(title: 'First post',
                            body: 'Body of the first post',
                            tags: 'some, tags, here') }

  def update_post(options={})
    options[:title] ||= 'Number 1 post'
    options[:body] ||= 'Body of the Number 1 post'
    options[:tags] ||= 'some, tags, here'

    visit '/posts'
    within "#post_#{post.id}" do
      click_link 'Edit'
    end

    fill_in 'Title', with: options[:title]
    fill_in 'Body', with: options[:body]
    fill_in 'Tags', with: options[:tags]
    click_button 'Update Post'

  end

  it 'updates a post successfully with correct information' do
    update_post
    post.reload

    expect(page).to have_content('Post was successfully updated.')
    expect(post.title).to eq('Number 1 post')
    expect(post.body).to eq('Body of the Number 1 post')
  end

  it 'displays an error with no title' do
    update_post title: ''
    expect(page).to have_content('error')
  end

  it 'displays an error with too short a title' do
    update_post title: 'A' * 4
    expect(page).to have_content('error')
  end

  it 'displays an error with too long a title' do
    update_post title: 'A' * 101
    expect(page).to have_content('error')
  end

  it 'displays an error with no body' do
    update_post body: ''
    expect(page).to have_content('error')
  end
end
