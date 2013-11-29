class Admin::AdminController < ApplicationController
	layout "admin"

  before_action :verify_admin_user

  private

    def verify_admin_user

      auth_users = ['gabrielmassote@gmail.com', 'vitor.gebara@hotmail.com', 'dlegrady@gmail.com', 'alexis.gourdol@hotmail.fr']

      unless auth_users.include?(@logged_user.email)
        puts "################# [Webiseum] Usuario nao autorizado acessando URL: " + url_for(params)
        redirect_to unregistered_webiseum_index_path
      end

    end
end