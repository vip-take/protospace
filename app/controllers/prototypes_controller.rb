class PrototypesController < ApplicationController
  def index
  end

  def new
    @proto = Prototype.new
    @user = current_user.id
  end

  def create
    Prototype.create(create_params)
    redirect_to :root
  end

  def show
  end

  private

  def create_params
    params.require(:prototype).permit(:title, :catchcopy, :concept).merge(user_id: current_user.id)
  end

end
