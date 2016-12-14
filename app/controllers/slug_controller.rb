class SlugController < ApplicationController

  def new
    @my_url = Slug.new
  end

  def create
    @my_url = Slug.new(params[:url])
    if @my_url.save
      flash[:slug] = @my_url.id
      redirect_to new_url_url
    else
      render :action => "new"
    end
  end

  def show
    @my_url = Slug.find(params[:id])
    redirect_to @my_url.url
  end

end
