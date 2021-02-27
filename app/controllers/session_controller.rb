class SessionController <ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      if user.email_confirmed
        PasswordMailer.welcome_email(user).deliver_now
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully."
      else
        PasswordMailer.registration_confirmation(user).deliver_now
        redirect_to sign_in_path, notice: "Please activate your account by following the instructions in the account confirmation email you received to proceed."
      end
    else
      redirect_to sign_in_path, notice: "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end