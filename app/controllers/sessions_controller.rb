class SessionsController < ApplicationController

  before_filter :signed_in_user, only: [ :new, :create ]

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user 
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
 
    def signed_in_user
      redirect_to root_path if signed_in? 
    end

end
