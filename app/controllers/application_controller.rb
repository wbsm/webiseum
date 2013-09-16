class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :verify_logged_user

  private

    def verify_logged_user

      unless Session.is_valid_user(session["user_id"])
        puts "################# [Webiseum] Usuario nao autorizado acessando URL: " + url_for(params)
        redirect_to new_user_landing_page_index_path
      else
        @logged_user = User.find(session['user_id'])
      end


    end
end