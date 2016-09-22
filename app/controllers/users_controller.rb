class UsersController < ApplicationController

  before_action :find_user, only: [:show, :update]

  def show
    find_user
    @protos = @user.prototypes.order("id DESC")
  end

  def edit
  end

  def update
    find_user
    if params[:user][:password] == ""
      @user.update(update_params)
      if @user.errors.present?
        flash[:error] = @user.errors.full_messages
        redirect_to :back and return
      end
    else
      @user.update(update_with_password_params)
      if @user.errors.present?
        flash[:error] = @user.errors.full_messages
        redirect_to :back and return
      end
      redirect_to '/users/sign_in' and return
    end
    redirect_to :root, notice: "Profile updated"
  end

  private
  def update_params
    params.require(:user).permit(:name, :email, :group, :profile, :works, :avatar)
  end

  def update_with_password_params
    params.require(:user).permit(:name, :email, :password , :password_confirmation, :group, :profile, :works, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
