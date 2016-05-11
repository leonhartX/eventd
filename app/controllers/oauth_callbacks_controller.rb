class OauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_oauth(request.env["omniauth.auth"].except("extra"))
    binding.pry
    if @user.persisted?
      flash.notice = "You have logged in!"
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end