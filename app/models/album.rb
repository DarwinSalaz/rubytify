class Album < ApplicationRecord
    belongs_to :artist
    has_many :songs, dependent: :destroy
    validates :name, presence: true
    validates :image, presence: true
    validates :spotify_url, presence: true
    validates :total_tracks, presence: true
    validates :spotify_id, presence: true
    validates :artist_id, presence: true    
end
