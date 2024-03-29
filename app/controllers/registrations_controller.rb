class RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!
  
    def edit
    end
  
    def update
      if current_user.update(user_params)
        redirect_to profiles_show_path, notice: 'Perfil actualizado exitosamente.'
      else
        render :edit
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :last_name, :address, :email) 
    end
  end
  