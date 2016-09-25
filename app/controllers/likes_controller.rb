class LikesController < ApplicationController

  def create
    @like = Like.create(create_params)
    @proto = Prototype.find(params[:like][:prototype_id])
  end

  def update
    Like.find(params[:id]).destroy
    @like = Like.new
    @proto = Prototype.find(params[:like][:prototype_id])
    @likes_count = @proto.likes_count
  end

  private
  def create_params
    params.require(:like).permit(:prototype_id).merge(user_id: current_user.id)
  end

end
