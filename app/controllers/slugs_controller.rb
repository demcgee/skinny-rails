class SlugsController < ApplicationController

  def new
    session[:referrer] = request.referrer
    session[:ip_address] = request.remote_ip
  end

  def index
    @slugs = Slug.all
  end

  def index
    @lookups = Lookup.all
  end

  def show
    raise "NOOOOOOO" unless params[:slug]
    @slug = Slug.find_by(slug: params[:slug])
    # create a new lookup @slug.lookups.create!( ... ? )
    #@slug.lookups.create!(:ip_address, :referrer, @slug.id)
    redirect_to @slug.given_url
  end

  def create
    @slug = Slug.new(slug_params)

    respond_to do |format|
      if @slug.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.', status: 201 }
        format.js
        format.json { render json: @slug, status: 201, location: @slug }
      else
        format.html { render action: 'new' }
        format.json { render json: @slug.errors, status: 400 }
      end
    end
  end

  def create
    @lookup = Lookup.new(lookup_params)

    respond_to do |format|
      if @lookup.save
        format.html { redirect_back fallback_location: root_path, status: 301 }
        format.js
        format.json { render json: @lookup, status: 301, location: :referrer }
      else
        format.html { render action: 'new' }
        format.json { render json: @lookup.errors, status: 404 }
      end
    end
  end

  private
    # {slug: {...}, other: {...}}
    def all_params
      params.permit(slug: [:given_url, :slug],
                    lookup: [:given_url, :lookup]).to_h
    end

    def slug_params
      all_params[:slug]
    end

    def lookup_params
      all_params[:lookup]
    end
end
