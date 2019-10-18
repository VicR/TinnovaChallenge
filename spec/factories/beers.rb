FactoryBot.define do
  factory :beer do
    user
    punk_id { 5 }
    name { 'Modelo' }
    tagline { 'La cerveza más fina' }
    description { 'A classic Mexican beer.' }
    abv { 4.7 }
    seen_at { DateTime.now }
  end
end
