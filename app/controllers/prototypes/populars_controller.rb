class Prototypes::PopularsController < ApplicationController

  def index
    @protos = Prototype.includes(:images).order("likes_count DESC").page(params[:page])
  end

end
