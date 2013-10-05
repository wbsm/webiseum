class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :verify_logged_user

  private

    def verify_logged_user

      @logged_user = User.find_by_id(session[:user_id])
      if @logged_user.nil?
        puts "################# [Webiseum] Usuario nao autorizado acessando URL: " + url_for(params)
        redirect_to signup_path
      end

    end
end