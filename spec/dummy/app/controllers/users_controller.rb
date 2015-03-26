class UsersController < BaseApiController
  actions :index, :show, :create, :update, :destroy

  private

  def permitted_params
    params.require(:user).permit(:id, :name, :email)
  end
end
