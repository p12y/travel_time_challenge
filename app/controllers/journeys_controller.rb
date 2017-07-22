class JourneysController < ApplicationController
  before_action :set_journey, only: [:edit, :update, :show, :destroy]

  def index
    @journeys = Journey.all
  end

  def show
  end

  def new
    @journey = Journey.new
  end

  def create
    @journey = Journey.new(journey_params)
    respond_to do |format|
      if @journey.save
        format.html { redirect_to journey_path(@journey) }
        flash[:notice] = 'Journey created'
      else
        format.html { render :new }
        flash[:alert] = @journey.errors.full_messages.to_sentence
        puts @journey.errors.full_messages.to_sentence
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @journey.update_attributes(journey_params)
        # Trigger before_save callbacks to refresh data
        # Need to find a better way as this is an expensive request
        @journey.meetings.update(updated_at: Time.current)
        format.html { redirect_to journey_path(@journey) }
        flash[:notice] = 'Journey updated'
      else
        format.html { render :edit }
        flash[:alert] = @journey.errors.full_messages.to_sentence
      end
    end
  end

  def destroy
    if @journey.destroy
      redirect_to journeys_url
    end
  end

  private
    def set_journey
      @journey = Journey.find(params[:id])
    end
    def journey_params
      params.require(:journey).permit(:name, :start_time, :start_date,
      meetings_attributes: [:id, :location, :duration, :name, :_destroy])
    end
end
