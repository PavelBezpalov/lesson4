require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }

  context 'user_id field' do
    it 'exists' do
      post = Post.create(title: 'First post',
                          body: 'Body of the first post',
                          tags: 'some, tags, here')
      post.user_id = 7
      expect(post.user_id).to eq(7)
    end

  end
end
