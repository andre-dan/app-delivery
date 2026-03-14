class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_name, presence: true
  validates :unit_price,   numericality: { greater_than_or_equal_to: 0 }
  validates :quantity,     numericality: { only_integer: true, greater_than: 0 }

  def as_api_json
    {
      id:                    id,
      product_id:            product_id,
      product_name:          product_name,
      unit_price:            unit_price.to_f,
      quantity:              quantity,
      customizations:        customizations,
      customizations_label:  customizations_label
    }
  end
end
