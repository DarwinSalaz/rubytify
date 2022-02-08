class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :popularity, :spotify_url, :spotify_id, :genres

  def genres
    self.object.genres.pluck(:name)
  end
end
