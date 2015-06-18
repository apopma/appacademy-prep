class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    flash.notice = "Deleted the tag '#{@tag.name}'"
    @tag.destroy
    redirect_to tags_path
  end
end
