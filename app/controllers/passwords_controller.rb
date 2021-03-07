class PasswordsController < ApplicationController
  before_action :require_user_logged_in
  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to root_path, notice: "Passoword updated"
    else
      render :edit
    end
  end

  def destroy
    @user = Current.user
    if @user.present?
      session[:user_id] = nil
      @user.destroy
      redirect_to root_path, notice: "Account has been deleted"
    else
      redirect_to root_path
    end
  end

  private

  def password_params
    params.require(:user).permit(:password,:password_confirmation)
  end

end