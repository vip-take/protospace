class Prototypes::TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.most_used.page(params[:page]).per(15)
  end

  def show
    @protos = Prototype.tagged_with(params[:id]).includes(:images).order("likes_count DESC").page(params[:page])
  end

end
