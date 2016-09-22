class PrototypesController < ApplicationController
  def index
    @protos = Prototype.includes(:images).order("id DESC").limit(6)
  end

  def new
    @proto = Prototype.new
    @proto.images.build
  end

  def create
    if params[:prototype][:images_attributes]["0"][:photo].present?
      Prototype.create(create_params)
    else
      flash[:error] = "Main image is required."
      redirect_to :back and return
    end
    redirect_to :root
  end

  def show
    @proto = Prototype.find(params[:id])
    @main = @proto.images.find_by(role: "main")
    @sub = @proto.images.sub
  end

  private

  def create_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:prototype_id,:photo, :role]).merge(user_id: current_user.id)
  end

end
