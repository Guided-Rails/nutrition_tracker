class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  before_action :redirect_authenticated_user, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end

    def redirect_authenticated_user
      redirect_to root_path if authenticated?
    end
end
