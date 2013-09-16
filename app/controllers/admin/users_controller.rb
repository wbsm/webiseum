class Admin::UsersController < Admin::AdminController
	layout "admin"

	def search
    	@users = User.where("full_name like ?", '%'+params[:search_field]+'%')
    	render "index"
  	end

	def index
    	@users = User.all    	
  end

	def edit
		@user = User.find(params[:id])
	end

	def create 
		@user = User.new(user_params)
		
		if @user.save
			redirect_to admin_user_path, notice: 'Cadastro criado com sucesso!'
		else 
			render action: :new
		end
	end

	def update
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			redirect_to admin_user_path, notice: 'Cadastro atualizado com sucesso!'
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
          :email
          #:password,
          #:password_confirmation
        )
    end
end