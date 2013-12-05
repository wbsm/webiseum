class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :user_time_zone

  private

    def user_time_zone(&block)
      if @logged_user.present? && @logged_user.time_zone.present?
        Time.use_zone(@logged_user.time_zone, &block)
      else 
        Time.use_zone(Time.zone, &block)
      end
    end

end