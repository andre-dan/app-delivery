class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :level, numericality: { greater_than: 0 }
  validates :xp_points, numericality: { greater_than_or_equal_to: 0 }

  before_save { email.downcase! }

  XP_PER_ORDER = 50

  def add_xp(points)
    self.xp_points += points
    while xp_points >= xp_to_next
      self.xp_points -= xp_to_next
      self.level     += 1
      self.xp_to_next = (xp_to_next * 1.3).ceil
    end
    save!
  end

  def as_api_json
    {
      id:               id,
      name:             name,
      email:            email,
      phone:            phone,
      avatar_url:       avatar_url,
      cashback_balance: cashback_balance.to_f,
      level:            level,
      xp_points:        xp_points,
      xp_to_next:       xp_to_next,
      badges:           badges
    }
  end
end
