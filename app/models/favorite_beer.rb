class FavoriteBeer < ApplicationRecord
  # validations
  validates :name,
            :tagline,
            :description,
            :seen_at, presence: true
  validates :abv,
            :punk_id, presence: true, numericality: true

  # relationships
  belongs_to :user
end
