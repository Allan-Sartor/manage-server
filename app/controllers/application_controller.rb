# ApiController: Classe base que todos os demais controllers herdarão por padrão.
# Esta classe é responsável por autenticar o usuário antes de cada ação e por lidar com permissões e erros comuns.
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include FormatHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:auth, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :email])
  end

  def show_not_found_errors(exception)
    render json: { error: "#{exception.message} with 'id'=#{params[:id]}" },
           status: :not_found
  end
end
