class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :verify_logged_user
  around_filter :user_time_zone

  private

    def user_time_zone(&block)
      if @logged_user.present?
        Time.use_zone(@logged_user.time_zone, &block) 
      else 
        Time.use_zone(Time.zone, &block) 
      end
    end

    def verify_logged_user
      puts "################# [Webiseum][ApplicationController] Filter SessionId: #{session[:user_id]}"
      @logged_user = User.find_by_id(session[:user_id])
      if @logged_user.nil?
        puts "################# [Webiseum][ApplicationController] Usuario nao autorizado acessando URL: " + url_for(params)
        redirect_to unregistered_path and return
      end

    end
end