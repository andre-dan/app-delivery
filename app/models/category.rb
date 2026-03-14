class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  default_scope { order(:position) }

  def as_api_json(include_products: false)
    h = {
      id:        id,
      name:      name,
      position:  position,
      image_url: image_url,
      emoji:     emoji
    }
    h[:products] = products.map(&:as_api_json) if include_products
    h
  end
end
