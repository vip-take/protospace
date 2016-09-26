class PrototypesController < ApplicationController
  def index
    @protos = Prototype.includes(:images).order("id DESC").page(params[:page])
  end

  def new
    @proto = Prototype.new
    @proto.images.build
  end

  def create
    @proto = Prototype.create(create_params)
    if @proto.errors.present?
      flash[:error] = @proto.errors.full_messages
      redirect_to :back and return
    end
    redirect_to :root
  end

  def show
    @proto = Prototype.find(params[:id])
    if @proto.likes.find_by(user_id: current_user.id).present?
      @like = @proto.likes.find_by(user_id: current_user.id)
    else
      @like = Like.new
    end
  end

  def edit
    @proto = Prototype.find(params[:id])
  end

  def update
    @proto = Prototype.find(params[:id])
    if @proto.save(update_params)
      flash[:notice] = 'Prototype is updated'
    elsif @proto.errors.present?
      flash[:error] = @proto.errors.full_messages
      redirect_to :back and return
    end
    redirect_to :root
  end

  def destroy
    @proto = Prototype.find(params[:id])
    @proto.destroy
    redirect_to :root
  end

  private

  def create_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:prototype_id,:photo, :role]).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:id, :prototype_id, :photo, :role]).merge(user_id: current_user.id)
  end

end
