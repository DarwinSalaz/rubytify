class GenresController < ApplicationController
    
    # GET /v1/genres/:genre_name/random_song
    def random_song
      @genre = Genre.find_by(name: params[:genre_name])
      if @genre
        begin
          @random_song = @genre.artists.sample.albums.sample.songs.sample
          render json: { data: @random_song.as_json(except: 
            [:id, :created_at, :updated_at, :spotify_id, :album_id]) }, status: :ok
        rescue => exception
            render json: {error: "song not found"}, status: 404   
        end    
      else
        render json: {error: "genre not found"}, status: 404
      end
    end
    
end
  