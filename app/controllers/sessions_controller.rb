class SessionsController < ApplicationController
  skip_before_filter :verify_logged_user

  def new
    @new_user = env['omniauth.identity'] || User.new
    render "webiseum/signup"
  end

  def create
    auth_hash = request.env['omniauth.auth']
    
    # time_zone do browser    
    auth_hash['time_zone'] = cookies["jstz_time_zone"]

    session.clear
    auth = Authentication.find_or_create(nil, auth_hash)

    session[:user_id] = auth.user.id.to_i
    redirect_to feed_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
    session.clear
    redirect_to unregistered_path
  end

end
