class JourneysController < ApplicationController
  def index
    @journeys = Journey.all
  end

  def new
  end

  def show
  end

  def destroy
  end
end
