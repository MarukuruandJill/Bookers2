class ApplicationController < ActionController::Base
 #before_action :authenticate_user!, except: [:top, :about]
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :authenticate_user!, except: [:top, :about]


  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    #@user = current_user
    #user_path(@user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  #def user_info_new_book
    #@user = current_user
    #@new_book = Book.new
  #end
end
