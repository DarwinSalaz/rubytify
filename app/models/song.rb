class Song < ApplicationRecord
    validates :name, presence: true
    validates :spotify_url, presence: true
    validates :preview_url, presence: true
    validates :duration_ms, presence: true
    validates :explicit, inclusion: { in: [true, false]}
    validates :spotify_id, presence: true
    belongs_to :album
end
