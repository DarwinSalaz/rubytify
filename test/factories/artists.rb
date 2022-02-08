FactoryBot.define do
  factory :artist do
    name { "name" }
    image { Faker::Lorem.sentence }
    popularity { 70 }
    spotify_url { "http:wiwjoiej.com" }
    spotify_id { "spotify_id" }
  end
end
