class Product < ApplicationRecord
  belongs_to :category

  # Integer mapping: both=0 (default), lunch=1, dinner=2
  enum :shift, { both: 0, lunch: 1, dinner: 2 }

  validates :name,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def as_api_json
    {
      id:               id,
      category_id:      category_id,
      name:             name,
      description:      description,
      price:            price.to_f,
      shift:            shift,
      image_url:        image_url,
      is_featured:      is_featured,
      is_customizable:  is_customizable,
      rating:           rating.to_f,
      rating_count:     rating_count,
      emoji:            emoji
    }
  end

  # Returns products available in the current time window:
  #   08:00–17:59 → :lunch and :both  (extended window for full afternoon)
  #   18:00–22:59 → :dinner and :both
  #   outside those windows → none
  scope :active_now, -> {
    hour = Time.current.hour

    if hour >= 8 && hour < 18
      where(shift: [:lunch, :both])
    elsif hour >= 18 && hour < 23
      where(shift: [:dinner, :both])
    else
      none
    end
  }
end
