class ArtistsController < ApplicationController

    rescue_from Exception do |e|
        render json: {error: e.message}, status: :internal_error
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end

    # GET /v1/artists
    def index
        @artists = Artist.all.order('popularity DESC')
        render json: @artists, status: :ok
    end

    # GET /v1/artists/:id/albums
    def albums
        begin
            artist = Artist.find(params[:id])
            render json: { data: artist.albums.as_json(except: 
                        [:created_at, :updated_at, :spotify_id, :artist_id]) }, status: :ok
        rescue => exception
            render json: {error: "artist does not exist"}, status: 404   
        end
    end

    # POST /artist
    def create
        @artist = Artist.create!(create_params)
        render json: @artist, status: :created
    end

    private

    def create_params
        params.require(:artist).permit(:name, :image, :genres, :popularity, :spotify_url, :spotify_id)
    end
end