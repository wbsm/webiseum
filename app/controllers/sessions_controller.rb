class SessionsController < ApplicationController
  skip_before_filter :verify_logged_user 

  def new
    # redirect to index with auth info
    redirect_to root_path
  end

  def create
    auth_hash = request.env['omniauth.auth']
    session_user_id = session[:user_id]
    
    # first loggin or not
    if session_user_id
      # add new the authorization provider [facebook, google+ or twitter] to the user
      logged_user = User.find(session_user_id)
      logged_user.add_provider(auth_hash)

      puts "################# [Webiseum] Usuario ja logado: " + logged_user.full_name.to_s
    else
      # log him in or sign him up
      # create the session
       auth = Authentication.find_or_create(auth_hash)

       session[:user_id] = auth.user.id
       puts "################# [Webiseum] Usuario acabou de logar: " + auth.user.full_name
    end
    
    # redirect to index with auth info
    redirect_to social_feed_index_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

end
