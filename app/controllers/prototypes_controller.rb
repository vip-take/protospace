class PrototypesController < ApplicationController
  def index
    # @protos = Prototype.all.order("id DESC").limit(6)
    @protos = Prototype.includes(:images).order("id DESC").limit(6)
  end

  def new
    @proto = Prototype.new
    @proto.images.build
  end

  def create
    binding.pry
    @hoge = Prototype.create(create_params)
    redirect_to :root
  end

  def show
  end

  private

  def create_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:prototype_id,:photo, :role]).merge(user_id: current_user.id)
  end

end
