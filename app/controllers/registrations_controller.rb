class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            PasswordMailer.registration_confirmation(@user).deliver_now
            if @user.email_confirmed
                PasswordMailer.welcome_email(@user).deliver_now
                session[:user_id] = @user.id
                redirect_to root_path , notice: "Account created successfully!"
            else
                redirect_to sign_in_path, notice: "Please confirm your email address to continue"
            end
        else
            render :new
        end
    end
    def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
          user.email_activate
          redirect_to sign_in_path , notice: "Welcome to Scheduled Tweet! Your email has been confirmed. Please sign in to continue."
        else
          redirect_to root_path, notice: "Sorry. User does not exist"
        end
    end

    private
    

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end