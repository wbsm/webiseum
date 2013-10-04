class Admin::AdminController < ApplicationController
	layout "admin"

  before_action :verify_admin_user

  private

    def verify_admin_user

      auth_users = ["gabrielmassote@gmail.com", "vitor.gebara@hotmail.com"]

      unless auth_users.include?(@logged_user.email)
        puts "################# [Webiseum] Usuario nao autorizado acessando URL: " + url_for(params)
        redirect_to new_user_landing_page_index_path
      end

    end
end