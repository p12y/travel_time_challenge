class JourneysController < ApplicationController
  def index
    @journeys = Journey.all
  end

  def new
    @journey = Journey.new
  end

  def create
  end

  def show
  end

  def destroy
  end

  private
    def journey_params
      params.require(:journey).permit(:name, :start_time, 
      meetings_attributes: [:id, :postcode, :duration, :name, :_destroy])
    end
end
