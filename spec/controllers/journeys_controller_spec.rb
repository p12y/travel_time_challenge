require 'rails_helper'

RSpec.describe JourneysController, type: :controller do
  describe "GET index" do
    it "assigns @journeys" do
      journey = create(:journey_with_meetings)
      get :index
      expect(assigns(:journeys)).to eq([journey])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    before(:each) { @journey = create(:journey_with_meetings) }

    it "assigns @journey" do
      get :show, params: { id: @journey.id }
      expect(assigns(:journey)).to eq(@journey)
    end

    it "renders the index template" do
      get :show, params: { id: @journey.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "assigns @journey" do
      get :new
      expect(assigns(:journey)).to be_a_new(Journey)
    end

    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates new record and redirects to show" do
        post :create, params: { journey: {name: "Test", start_time: '1:00pm', 
                                start_date: '20/07/2017', meetings_attributes: 
                                  {'0': {name: 'Foo', location: 'The Shard', 
                                  duration: 0, _destroy: 'false'}}} } 
        expect(Meeting.count).to eq 1
        journey = Journey.last
        expect(response).to redirect_to journey_url(journey)
      end
    end

    context "with invalid attributes" do
      it "doesn't create new record and renders #new" do
        post :create, params: { journey: {name: "", start_time: '1:00pm', 
                                start_date: '20/07/2017', meetings_attributes: 
                                  {'0': {name: 'Foo', location: 'The Shard', 
                                  duration: 0, _destroy: 'false'}}} } 
        expect(Meeting.count).to eq 0
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before(:each) { @journey = create(:journey_with_meetings) }   
    
    it "assigns @journey" do
      get :edit, params: { id: @journey.id }
      expect(assigns(:journey)).to eq(@journey)
    end

    it "renders the edit template" do
      get :edit, params: { id: @journey.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST update" do
    before(:each) { @journey = create(:journey_with_meetings) }

    context "with valid attributes" do
      it "updates record and redirects to show" do
        post :update, params: { journey: {name: 'bar'}, id: @journey.id } 
        journey = Journey.last
        expect(journey.name).to eq 'bar'
        expect(response).to redirect_to journey_url(journey)
      end
    end

    context "with invalid attributes" do
      it "doesn't update record and renders #edit" do
        post :update, params: { journey: {name: ''}, id: @journey.id } 
        journey = Journey.last
        expect(journey.name).to eq 'Journey1'
        expect(response).to render_template("edit")
      end
    end
  end

  describe "POST destroy" do
    it "deletes record" do
      @journey = create(:journey_with_meetings)
      post :destroy, params: { id: @journey.id } 
      expect(Journey.count).to eq 0
      expect(Meeting.count).to eq 0
      expect(response).to redirect_to journeys_url
    end
  end
end

