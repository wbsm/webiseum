class SessionsController < ApplicationController
  layout 'webiseum'

  def new
    @new_user = env['omniauth.identity'] || User.new
    render "webiseum/signup"
  end

  def new_user_redirect


  end

  def create
    auth_hash = request.env['omniauth.auth']
    
    # time_zone do browser    
    auth_hash['time_zone'] = cookies["jstz_time_zone"]

    session.clear
    auth = Authentication.find_or_create(auth_hash)

    session[:user_id] = auth.user.id.to_i

    if auth.user.is_new
      render "webiseum/new_user_redirect" and return
    end

    redirect_to feed_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def failure
    flash[:login_error] = "Usuário/Senha inválidos..."
    session.clear
    render "webiseum/unregistered" and return
  end

end
