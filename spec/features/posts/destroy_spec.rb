require 'rails_helper'

describe 'Deleting posts' do
  let!(:post) { Post.create(title: 'First post',
                            body: 'Body of the first post',
                            tags: 'some, tags, here') }

  it 'is successful when clicking the destroy link' do
    visit '/posts'

    within "#post_#{post.id}" do
      click_link 'Destroy'
    end

    expect(page).to_not have_content(post.title)
    expect(Post.count).to eq(0)
  end
end
