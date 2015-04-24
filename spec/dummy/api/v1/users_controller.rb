class Api::V1::::UsersController < BaseApiController
  before_action :authenticate_user!  
  actions :index, :show

  private

  def permitted_params
    params.require(:user).permit(:id, :name, :email)
  end
end
