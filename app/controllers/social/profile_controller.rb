class Social::ProfileController < Social::SocialController

  def show
    @user = User.find_by_id(session[:user_id])
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if @user.present? && @user.update(user_params)
      Authentication.create_identity_auth(@user) if password_updated
      redirect_to social_profile_path(@user), notice: 'Perfil atualizado com sucesso!'
    else
      render action: :edit
    end
  end

  private
    def password_updated
      !user_params['password'].empty?
    end

    def user_params
      params
      .require(:user)
      .permit(
          :first_name,
          :last_name,
          :email,
          #:birthdate,
          #:gender,
          :avatar,
          :password,
          :password_confirmation
      )
    end
end
