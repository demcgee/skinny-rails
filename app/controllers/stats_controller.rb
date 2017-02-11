class StatsController < ApplicationController

  def show
    @stat = Stat.find_by(:slug_id)
  end

  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to root_path, status: 200}
        format.js
        format.json { render json: @stat, status: 200, location: @stat }
      else
        format.html { render action: 'new' }
        format.json { render json: @stat.errors, status: 404 }
      end
    end
  end

  private

  def stat_params
      params.permit(stat: [referrer])
  end
end
