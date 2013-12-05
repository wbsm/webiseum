class Admin::AdminController < ApplicationController
	layout "admin"

  before_action :verify_logged_user, :verify_admin_user

  private

    def verify_logged_user

      @logged_user = User.find_by_id(session[:user_id])
      if @logged_user.nil?
        redirect_to unregistered_path and return
      end

    end

    def verify_admin_user
      auth_users = ['gabrielmassote@gmail.com', 'vitor.gebara@hotmail.com', 'dlegrady@gmail.com', 'alexis.gourdol@hotmail.fr']

      unless auth_users.include?(@logged_user.email)
        redirect_to unregistered_path
      end

    end
end