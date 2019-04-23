class Subscribers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    sign_in_and_redirect Subscriber.from_omniauth(request.env['omniauth.auth'])
  end

  def failure
    redirect_to root_path
  end
end
