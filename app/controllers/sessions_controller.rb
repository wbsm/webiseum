class SessionsController < ApplicationController
  skip_before_filter :verify_logged_user

  def new
    @new_user = env['omniauth.identity'] || User.new
    render "webiseum/signup"
  end

  def create
    auth_hash = request.env['omniauth.auth']
    session_user_id = session[:user_id]

    if session_user_id.nil?
      auth = Authentication.find_or_create(nil, auth_hash)
    else
      user = User.find_by_id(session_user_id)
      # se possui session_id mas nao esta registrado no BD
      redirect_to signup_path && return if user.nil?

      auth = Authentication.find_or_create(user, auth_hash)
    end

    session[:user_id] = auth.user.id
    redirect_to social_feed_index_path
=begin
  # first login
    unless session_user_id
     auth = Authentication.find_or_create(auth_hash)

      session[:user_id] = auth.user.id
      puts "################# [Webiseum] Usuario acabou de logar: " + auth.user.email.to_s
    else
      logged_user = User.find_by_id(session_user_id)

      if !logged_user.nil?
        logged_user.build_provider(auth_hash)

        puts "################# [Webiseum] Usuario acabou de logar: " + logged_user.to_s
      else
        puts "################# [Webiseum] Usuario nao autorizado..."
        # redirect to index with auth info
        redirect_to unregistered_webiseum_index_path && return
      end

    end

    # redirect to index with auth info
    redirect_to social_feed_index_path
=end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
    session[:user_id] = nil
    redirect_to signup_path
  end

end
