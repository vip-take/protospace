class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password] == "" then
      @user.update(update_params)
    else
      @user.update(update_with_password_params)
      redirect_to '/users/sign_in' and return
    end
    redirect_to :root and return
  end

  private
  def update_params
    params.require(:user).permit(:name, :email, :group, :profile, :works)
  end

  def update_with_password_params
    params.require(:user).permit(:name, :email, :password , :password_confirmation, :group, :profile, :works)
  end

end
