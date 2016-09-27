class Prototypes::NewestsController < ApplicationController

  def index
    @protos = Prototype.includes(:images).order("id DESC").page(params[:page])
  end

end
