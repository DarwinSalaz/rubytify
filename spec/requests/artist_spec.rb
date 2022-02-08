require "rails_helper"
require "byebug"

RSpec.describe "Artists endpoint", type: :request do

  describe "GET /artists" do
    before { get '/artists' }

    it "should return OK" do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "with data in the DB" do
    let!(:artists) { create_list(:artist, 10, popularity: 70) }
    
    it "should return all the artists" do
        get '/artists'
        #byebug
        payload = JSON.parse(response.body)

        expect(payload.size).to eq(artists.size)
        expect(response).to have_http_status(200)
    end
  end
end