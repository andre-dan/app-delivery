class Order < ApplicationRecord
  belongs_to :user
  has_many   :order_items, dependent: :destroy

  enum :status, {
    pending:    0,
    accepted:   1,
    preparing:  2,
    on_the_way: 3,
    delivered:  4,
    cancelled:  5
  }

  enum :payment_method, {
    pix:    0,
    card:   1,
    wallet: 2
  }

  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :order_items, presence: true

  CASHBACK_RATE = 0.05  # 5 % cashback

  after_create :grant_cashback_and_xp

  def as_api_json
    {
      id:               id,
      status:           status,
      total:            total.to_f,
      delivery_address: delivery_address,
      payment_method:   payment_method,
      cashback_earned:  cashback_earned.to_f,
      cashback_used:    cashback_used.to_f,
      promo_code:       promo_code,
      discount:         discount.to_f,
      created_at:       created_at.iso8601,
      items:            order_items.map(&:as_api_json)
    }
  end

  private

  def grant_cashback_and_xp
    earned = (total * CASHBACK_RATE).round(2)
    update_column(:cashback_earned, earned)
    user.increment!(:cashback_balance, earned)
    user.add_xp(User::XP_PER_ORDER)
  end
end
