class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Your successfully logging in!'
      redirect_to posts_path
    else
      flash[:error] ='There was a problem logging in. Please check your email and password.'
      render action: 'new'
    end
  end
end
