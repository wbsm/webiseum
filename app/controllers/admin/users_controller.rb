class Admin::UsersController < Admin::AdminController
	layout "admin"
  before_action :set_user, only: [:show, :edit, :update, :destroy]

	def search
    	@users = User.where("full_name like ?", '%'+params[:search_field]+'%')
    	render "index"
  	end

	def index
    	@users = User.all    	
  end

	def edit

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
		if @user.update(user_params)
			redirect_to admin_user_path, notice: 'Cadastro atualizado com sucesso!'
		else 
			render action: :edit
		end
	end

	def show 

	end

  def destroy
    Authentication.destroy(@user.id)
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path }
      format.json { head :no_content }
    end
  end

	private

    def set_user
      @user = User.find(params[:id])
    end

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