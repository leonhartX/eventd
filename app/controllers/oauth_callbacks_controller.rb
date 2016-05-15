class OauthCallbacksController < Devise::OmniauthCallbacksController
  User.supported_providers.each do |provider, name|
    define_method provider do
      @user = User.from_oauth(request.env["omniauth.auth"].except("extra"))
      if @user.persisted?
        flash[:success] = "You have logged in #{name}!"
        sign_in_and_redirect @user
      else
        session["devise.user_attributes"] = @user.attribute
        redirect_to events_path
      end
    end
  end

  def failure
    flash[:danger] = "login failure"
    redirect_to events_path
  end
end
