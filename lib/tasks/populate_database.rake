require 'em-resolv-replace'
namespace :db do

    desc 'Fetch database from external service'
    task :fetch_database => :environment do
        
        # autenticate api spotify
        RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

        # reset database
        Genre.destroy_all
        Album.destroy_all
        Song.destroy_all
        Artist.destroy_all

        # upload artist file
        @artists_file = YAML.load(File.read("artists_spotify.yml"))

        # fetch artists
        @artists_file["artists"].each do |artist|
            @artist_rec = RSpotify::Artist.search(artist.to_s)
            @artist_spotify = @artist_rec.first
            puts "Loading info for artist: " + @artist_spotify.name
            
            if @artist_spotify
                @artist_record = Artist.create({
                    name: @artist_spotify.name,
                    image: @artist_spotify.images[0]["url"],
                    popularity: @artist_spotify.popularity,
                    spotify_url: @artist_spotify.external_urls["spotify"],
                    spotify_id: @artist_spotify.id
                })

                @artist_record.save!
            end

            @artist_spotify.genres.each do |genre|
                begin
                  @new_genre = Genre.create({ name: genre })
                  @new_genre.save!
                  @artist_record.genres << @new_genre
                rescue => exception
                end
                @existing_genre = Genre.find_by(name: @new_genre.name)
                @artist_record.genres << @existing_genre unless @artist_record.genres.include?(@existing_genre)
            end
        end


        # fetch albums
        @artists_records = Artist.all
        @artists_records.each do |artist|
            @res = RSpotify::Artist.find(artist.spotify_id)
            puts "Loading albums for artist: " + artist.name
            if @res
                @res.albums.each do |album|
                    @new_album = Album.create({
                        name: album.name,
                        image: album.images.size > 0 ? album.images[0]["url"] : 'not found',
                        spotify_url: album.external_urls["spotify"],
                        total_tracks: album.total_tracks,
                        spotify_id: album.id,
                        artist_id: artist.id
                    })
                    @new_album.save!
                end
            end
        end

        # fetch songs
        @albums_records = Album.all 
        @albums_records.each do |album|
            @res = RSpotify::Album.find(album.spotify_id)
            puts "Loading songs for album: " + album.name
            if @res
                @res.tracks.each do |track|
                    @new_song = Song.create({
                        name: track.name,
                        spotify_url: track.external_urls["spotify"],
                        preview_url: track.preview_url ? track.preview_url : 'not found',
                        duration_ms: track.duration_ms ? track.duration_ms : 'not found',
                        explicit: track.explicit ? track.explicit : false,
                        spotify_id: track.id,
                        album_id: album.id
                    })
                    @new_song.save!
                end
            end
        end
        
    end
end