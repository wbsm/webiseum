class Social::ProfileController < Social::SocialController
  layout "social"

  def show

  end

  def edit

  end

  def update
    if @logged_user.update(logged_user_params)
      Authentication.create_webiseum_auth(@logged_user) if password_updated
      redirect_to social_profile_path(@logged_user), notice: 'Perfil atualizado com sucesso!'
    else
      render action: :edit
    end
  end

  private
    def password_updated
      !logged_user_params['password'].empty?
    end

    def logged_user_params
      params
      .require(:user)
      .permit(
          :first_name,
          :last_name,
          :email,
          #:birthdate,
          #:gender,
          :password,
          :password_confirmation
      )
    end
end
