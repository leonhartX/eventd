class OauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_oauth(request.env["omniauth.auth"].except("extra"))
    if @user.persisted?
      flash[:success] = "You have logged in!"
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attribute
      redirect_to events_path
    end
  end

  def failure
    flash[:danger] = "login failure"
    redirect_to events_path
  end
end
