require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "MyString",
      :email => "pavel.bezpalov@cyber-wizard.com",
      :password => "12345678",
      :password_confirmation => "12345678"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_password[name=?]", "user[password]"
      
      assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
    end
  end
end
