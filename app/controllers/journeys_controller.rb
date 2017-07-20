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

end
