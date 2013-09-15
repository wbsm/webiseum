class Admin::UsersController < ApplicationController
	layout "admin"

	def search
    	@users = User.where("full_name like ?", '%'+params[:search_field]+'%')
    	render "index"
  	end

	def index
    	@users = User.all    	
  end

	def edit
		@logged_user = User.find(params[:id])
	end

	def create 
		@logged_user = User.new(user_params)
		
		if @logged_user.save
			redirect_to @logged_user, notice: 'Cadastro criado com sucesso!'
		else 
			render action: :new
		end
	end

	def update
		@logged_user = User.find(params[:id])
		
		if @logged_user.update(user_params)
			redirect_to @logged_user, notice: 'Cadastro criado com sucesso!'
		else 
			render action: :edit
		end
	end

	def show 
		@logged_user = User.find(params[:id])
	end

	private

    def user_params
      params
        .require(:logged_user)
        .permit(
          :full_name,
          :email,
          :password,
          :password_confirmation
        )
    end
end