module AuthenticationHelpers
  def sign_in(user)
    allow(controller).to receive(:current_user).and_return(user)
    # allow(controller).to receive(:user_id).and_return(user.id)
  end
end