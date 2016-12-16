class SlugController < ApplicationController

  def show
    if params[:slug]
      @slug = Slug.find_by(slug: params[:slug])
      if redirect_to @slug.given_url
        @slug.save
      end
    else
      @slug = Slug.find(params[:id])
    end
  end

  def create
    @slug = Slug.new(slug_params)

    respond_to do |format|
      if @slug.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @slug }
      else
        format.html { render action: 'new' }
        format.json { render json: @slug.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def slug_params
      params.require(:given_url).permit(:slug)
    end
end
