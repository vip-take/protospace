class LikesController < ApplicationController

  def create
    @like = Like.create(create_params)
    @proto = Prototype.find(params[:prototype_id])
  end

  def destroy
    Like.find(params[:id]).destroy
    @like = Like.new
    @proto = Prototype.find(params[:prototype_id])
  end

  private
  def create_params
    params.permit(:prototype_id).merge(user_id: current_user.id)
  end

end
