class PrototypesController < ApplicationController
  def new
    @proto = Prototype.new
    @proto.images.build
 end

  def create
    tag_params
    @proto = Prototype.create(create_params)
    if @proto.errors.present?
      flash[:error] = @proto.errors.full_messages
      redirect_to :back and return
    end
    redirect_to :root
  end

  def show
    @proto = Prototype.find(params[:id])
    @comment = Comment.new
    if @proto.likes.find_by(user_id: current_user.id).present?
      @like = @proto.likes.find_by(user_id: current_user.id)
    else
      @like = Like.new
    end
  end

  def edit
    @proto = Prototype.find(params[:id])
    @tags = []
    @proto.tags.each do |tag|
      @tags << tag
    end
  end

  def update
    tag_params
    @proto = Prototype.find(params[:id])
    if @proto.update(update_params)
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
  def tag_params
   array = params[:tags]
   @tag_list = array.join(",")
  end

  def create_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:prototype_id,:photo, :role]).merge(user_id: current_user.id, tag_list: @tag_list)
  end

  def update_params
    params.require(:prototype).permit(:title, :catchcopy, :concept, images_attributes: [:id, :prototype_id, :photo, :role]).merge(user_id: current_user.id, tag_list: @tag_list)
  end

end
