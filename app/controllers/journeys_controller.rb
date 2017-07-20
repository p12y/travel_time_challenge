class JourneysController < ApplicationController
  def index
    @journeys = Journey.all
  end

  def show
  end

  def destroy
  end
end
