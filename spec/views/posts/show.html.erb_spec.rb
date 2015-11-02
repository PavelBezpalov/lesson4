require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(title: 'First post',
                                       body: 'Body of the first post',
                                       tags: 'some, tags, here'))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First post/)
    expect(rendered).to match(/Body of the first post/)
    expect(rendered).to match(/some, tags, here/)
  end
end
