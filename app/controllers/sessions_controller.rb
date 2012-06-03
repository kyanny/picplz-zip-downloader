
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_client_id(auth['provider'], auth['client_id']) || User.create_with_omniauth(auth)
    session['user_id'] = user.id
    redirect_to :root, :notice => 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, :notice => 'Signed out!'
  end
end
