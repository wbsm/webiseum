class UsersController < ApplicationController
	layout "admin"
	skip_before_filter :verify_logged_user, :only => [:new]

	def search
    	@users = User.where("full_name like ?", '%'+params[:search_field]+'%')
    	render "index"
  	end

	def index
    	@users = User.all    	
  	end

	def new 
		render layout: "application"
	end

	def edit
		@user = User.find(params[:id])
	end

	def create 
		@user = User.new(user_params)
		
		if @user.save
			redirect_to @user, notice: 'Cadastro criado com sucesso!'
		else 
			render action: :new
		end
	end

	def update
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			redirect_to @user, notice: 'Cadastro criado com sucesso!'
		else 
			render action: :edit
		end
	end

	def show 
		@user = User.find(params[:id])
	end

	private

	def user_params
      params
      	.require(:user)
      	.permit(
      		:full_name, 
      		:email, 
      		:password, 
      		:password_confirmation
      	)
    end
end