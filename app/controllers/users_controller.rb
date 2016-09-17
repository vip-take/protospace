class UsersController < ApplicationController

  before_action :find_user, only: [:show, :update]

  def show
    find_user
  end

  def edit
  end

  def update
    find_user
    if params[:user][:password] == ""
      @user.update(update_params)
    else
      @user.update(update_with_password_params)
      redirect_to '/users/sign_in' and return
    end
    redirect_to :root
  end

  private
  def update_params
    params.require(:user).permit(:name, :email, :group, :profile, :works)
  end

  def update_with_password_params
    params.require(:user).permit(:name, :email, :password , :password_confirmation, :group, :profile, :works)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
