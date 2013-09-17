class Social::ProfileController < Social::SocialController
  layout "social"

  def show
    puts 'aloasdfasd'
  end

  def edit

  end

  def update
    @logged_user = User.find(params[:id])

    if @logged_user.update(logged_user_params)
      redirect_to social_profile_path(@logged_user), notice: 'Perfil atualizado com sucesso!'
    else
      render action: :edit
    end
  end

  private
    def logged_user_params
      params
      .require(:user)
      .permit(
          :full_name,
          :email
      )
    end
end
