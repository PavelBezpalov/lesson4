require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(title: 'First post',
                   body: 'Body of the first post',
                   tags: 'some, tags, here'),
      Post.create!(title: 'Second post',
                   body: 'Body of the second post',
                   tags: 'some, tags, here')
    ])
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', 'First post'
    assert_select 'tr>td', 'Second post'
    assert_select 'tr>td', 'Body of the first post'
    assert_select 'tr>td', 'Body of the second post'
    assert_select 'tr>td', 'some, tags, here', count: 2
  end
end
