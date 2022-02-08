class Artist < ApplicationRecord
    validates :name, presence: true
    validates :image, presence: true
    #validates :genres, presence: true
    validates :popularity, presence: true
    validates :spotify_url, presence: true
    validates :spotify_id, presence: true
    has_and_belongs_to_many :genres
    has_many :albums, dependent: :destroy
end
